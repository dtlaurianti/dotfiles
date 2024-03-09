# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
    kmonad =  import ./home/kmonad.nix;
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../kmonad/nix/nixos-module.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
      enable = true;
      xkbModel = "pc86";
      layout = "us";
      xkbVariant = "";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.groups = { uinput = {}; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dtl = {
    isNormalUser = true;
    description = "Dylan Laurianti";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" ];
    packages = with pkgs; [
      firefox
      brave
    #  thunderbird
    ];
  };

  # kmonad config
  services.udev.extraRules =
    ''
      # KMonad user access to /dev/uinput
      KERNEL=="uinput", MODE="0660", GROUP="uinput", TAG+="uaccess", OPTIONS+="static_node=uinput"
    '';

     services.kmonad = {
     enable = true;
     keyboards = {
 	  kcq1 = {
 	    device = "/dev/input/by-id/usb-Keychron_Keychron_Q1-event-kbd";
 	    config = ''
(defcfg
  input  (device-file "/dev/input/by-id/usb-Keychron_Keychron_Q1-event-kbd")
  output (uinput-sink "KMonad kbd")
  fallthrough true
  )

(defsrc
  esc   f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11   f12    del
  `     1    2    3    4    5    6    7    8    9    0    -     =      bspc              pgup
  tab   q    w    e    r    t    y    u    i    o    p    [     ]      \                 pgdn
  caps  a    s    d    f    g    h    j    k    l    ;    '     ret                      ins
  lsft  z    x    c    v    b    n    m    ,    .    /    rsft         up
  lctl  lmet lalt      spc       cmp  ralt rctl                 left   down   rght
  )

(deflayer base
  caps  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11   f12    del
  `     1    2    3    4    5    6    7    8    9    0    -     =      bspc              pgup
  tab   q    w    e    r    t    y    u    i    o    p    [     ]      \                 pgdn
  esc   a    s    d    f    g    h    j    k    l    ;    '     ret                      ins
  lsft  z    x    c    v    b    n    m    ,    .    /    rsft         up
  lctl  lmet lalt      spc       cmp  ralt rctl                 left   down   rght
  )

		    '';
 	  };
     }; 
	package = import ./home/kmonad.nix;
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dtl";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    which file tree
    wget curl
    lsd bat jq ripgrep fzf
    autojump
    tldr
    zip unzip zstd
    starship
    tmux tmuxifier
    git lazygit git-graph
    vim neovim
    neofetch htop iotop iftop
    nix-output-monitor
    kmonad

    gcc
    rustc cargo
    nodejs
    ruby
  ];

  # Fonts to install
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
