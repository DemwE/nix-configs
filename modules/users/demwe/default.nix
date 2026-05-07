{ ... }:
{
  imports = [
    ./home.nix
    ./avatar.nix
  ];

  users.users.demwe = {
    isNormalUser = true;
    description = "DemwE";
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
    ];
  };
  nix.settings.trusted-users = [ "demwe" ];
}
