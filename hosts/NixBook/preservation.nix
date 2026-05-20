{
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs
    mount -t btrfs /dev/disk/by-uuid/4749bcc1-1605-4812-9ae3-b3e733bb6dfa /btrfs

    if [ -e /btrfs/@root ]; then
      if [ -e /btrfs/@root/var/empty ]; then
        echo "--> removing immutability from /btrfs/@root/var/empty..."
        chattr -i /btrfs/@root/var/empty
      fi

      timestamp=$(date +%Y-%m-%d_%H-%M-%S)
      echo "--> moving existing @root to /btrfs/old_roots/@root_$timestamp..."
      mkdir -p /btrfs/old_roots
      mv /btrfs/@root "/btrfs/old_roots/@root_$timestamp"
    fi

    echo "--> creating new @root subvolume..."
    btrfs subvolume create /btrfs/@root

    umount /btrfs
  '';

  preservation = {
    enable = true;

    preserveAt."/persist" = {
      files = [
        {file = "/etc/machine-id"; inInitrd = true;}
      ];
      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/lib/bluetooth"
        "/var/lib/cups"
        "/var/lib/fprint"
        "/var/lib/AccountsService"
        "/var/lib/flatpak"
        "/var/lib/containers/storage"
        "/var/db/sudo"
        "/etc/NetworkManager/system-connections"
      ]
    };
  }
}