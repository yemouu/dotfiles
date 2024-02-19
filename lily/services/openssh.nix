{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 36823 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.mou.openssh.authorizedKeys.keys =
    [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKnyBRVRLKrlsAlMFXimvcF/mBjmSfixdzUX4yCZsYvE" ];
}
