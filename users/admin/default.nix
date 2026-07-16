{ lib, config, ... }:
{
  imports = [
    ./home.nix
  ];

  options.my.users.admin.enable = lib.mkEnableOption "admin user";

  config = lib.mkIf config.my.users.admin.enable {
    users.users.admin = {
      isNormalUser = true;
      description = "Admin";
      extraGroups = [
        "networkmanager"
        "wheel"
        "storage"
        "plugdev"
        "libvirtd"
        "docker"
        "podman"
        "wireshark"
        "dialout"
        "video"
        "audio"
        "input"
        "uucp"
        "adbusers"
        "incus-admin"
      ];
      hashedPassword = "$6$wGYsg/EcdEhsP1AG$KzawdbGJRW.pKvqZFU0IzE38v9Aulb.tAq3cTwX5YO95qD5hFd28mq1Yp2flfFeKTKInVg/JQfJUBmBsOqlnz.";
      subUidRanges = [
        {
          startUid = 100000;
          count = 65536;
        }
      ];
      subGidRanges = [
        {
          startGid = 100000;
          count = 65536;
        }
      ];
    };
    nix.settings.trusted-users = [ "admin" ];
  };
}
