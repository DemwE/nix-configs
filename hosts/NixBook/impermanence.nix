{ inputs, lib, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs
    mount -t btrfs /dev/disk/by-uuid/4749bcc1-1605-4812-9ae3-b3e733bb6dfa /btrfs

    if [ -e /btrfs/@root ]; then
        echo "--> moving existing @root to /btrfs/old_roots/@root_TIMESTAMP ..."
        mkdir -p /btrfs/old_roots
        timestamp=$(date +%Y-%m-%d_%H-%M-%S)
        mv /btrfs/@root "/btrfs/old_roots/@root_$timestamp"
    fi

    echo "--> creating new @root subvolume..."
    btrfs subvolume create /btrfs/@root

    umount /btrfs
  '';

  #
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
      "/var/lib/cups"
      "/var/lib/fprint"
      "/var/lib/AccountsService"
      "/var/lib/flatpak"
      "/var/lib/containers/storage"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
