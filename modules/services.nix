{ ... }:
{
  # Misc system service enablement grouped for convenience.
  services = {
    # SSH daemon for remote access
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
    # Removable storage / disk management
    udisks2.enable = true;
    udisks2.mountOnMedia = true;
    # Virtual filesystem helpers (smb, sftp, etc.)
    gvfs.enable = true;
    # Thumbnail generation for file managers
    tumbler.enable = true;
  };

  # Basic network hardening
  networking.firewall.enable = true;
}
