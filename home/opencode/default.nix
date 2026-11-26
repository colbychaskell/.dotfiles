{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      permission = {
        edit = "allow";
        bash = "allow";
        webfetch = "allow";
      };
      # To route OpenCode through Amazon Bedrock instead of the OpenCode
      # Console provider, uncomment the settings below and run
      # `aws sso login --profile default` first.
      # model = "amazon-bedrock/us.anthropic.claude-sonnet-4-6";
      # providers.amazon-bedrock.settings = {
      #   profile = "default";
      #   region = "us-east-1";
      # };
    };

    cli = {
      theme = {
        name = "everforest-orange";
        mode = "dark";
      };
      session.sidebar = "hide";
    };

    # Everforest (medium) palette from the Neovim config, with the dashboard's
    # orange (#e69875) as the dominant accent and a transparent base background.
    themes."everforest-orange" = ./themes/everforest-orange.json;
  };
}
