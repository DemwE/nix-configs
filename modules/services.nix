{ ... }:
{
  # System services grouping (mirrors legacy structure)
  services = {
    # SSH daemon
    openssh.enable = true;
    # Removable media / storage management
    udisks2.enable = true;
    udisks2.mountOnMedia = true;

    # GVFS for virtual file system integration (e.g. smb, sftp in file managers)
    gvfs.enable = true;

    # Thumbnail generation daemon
    tumbler.enable = true;

    # Secret storage / keyring integration
    gnome.gnome-keyring.enable = true;
  };

  # Container / virtualization related services (docker moved to feature flag module)
  virtualisation = { };
}
