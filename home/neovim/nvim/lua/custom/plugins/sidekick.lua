return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  opts = {
    cli = {
      -- Claude Code running against Amazon Bedrock instead of the Anthropic API.
      -- Credentials come from your AWS profile (SSO), so run
      -- `aws sso login` before starting a session.
      tools = {
        claude = {
          env = {
            CLAUDE_CODE_USE_BEDROCK = "1",
            AWS_PROFILE = "default",
            AWS_REGION = "us-east-1",
          },
        },
        -- By default OpenCode uses the OpenCode Console provider configured in
        -- ~/.config/opencode/opencode.json. To use Bedrock from sidekick,
        -- uncomment this block and enable the amazon-bedrock provider in
        -- home/opencode/default.nix.
        -- opencode = {
        --   env = {
        --     AWS_PROFILE = "default",
        --     AWS_REGION = "us-east-1",
        --   },
        -- },
      },
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Detach CLI Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Select Prompt",
    },
    {
      "<leader>ao",
      function()
        require("sidekick.cli").toggle({ name = "opencode", focus = true })
      end,
      desc = "Toggle OpenCode",
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "claude", focus = true })
      end,
      desc = "Toggle Claude (Bedrock)",
    },
  },
}
