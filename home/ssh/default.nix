{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "config.d/*" ];
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ServerAliveInterval = 29;
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
