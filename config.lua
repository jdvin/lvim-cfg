-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.format_on_save = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black", filetypes = { "python" } }
}

lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"
lvim.keys.normal_mode["<C-Right>"] = ":bnext<CR>"
lvim.keys.normal_mode["<C-Left>"] = ":bprev<CR>"


lvim.plugins = {
  'luk400/vim-jukit',
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "hrsh7th/nvim-cmp",
  { "folke/neodev.nvim", opts = {} },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "v0.0.1", -- It is recommended that you keep this pinned to a tag
    -- so that you do not pick up breaking changes
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      -- This would be an optional dependency eventually
      "nvim-telescope/telescope.nvim",
    },
    {
      -- Configuration for SSH connections made using this plugin
      ssh_config = {
        -- Binary with this name would be searched on your runtime path and would be
        -- used to run SSH commands. Rename this if your SSH binary is something else
        ssh_binary = "ssh",
        -- Similar to `ssh_binary`, but for copying over files onto remote server
        scp_binary = "scp",
        -- All your SSH config file paths.
        ssh_config_file_paths = { "$HOME/.ssh/config" },
        -- This helps the plugin to understand when the underlying binary expects
        -- input from user. This is useful for password-based authentication and
        -- key-based authentication.
        -- Explanation for each prompt:
        -- match - string - This would be matched with the SSH output to decide if
        -- SSH is waiting for input. This is a plain match (not a regex one)
        -- type - string - Takes two values "secret" or "plain". "secret" indicates
        -- that the value you would enter is a secret and should not be logged into
        -- your input history
        -- input_prompt - string - What is the input prompt that should be shown to
        -- user when this match happens
        -- value_type - string - Takes two values "static" and "dynamic". "static"
        -- means that the value can be cached for the same prompt for future commands
        -- (e.g. your password) so that you do not have to keep typing it again and
        -- again. This is retained in-memory and is not logged anywhere. When you
        -- close the editor, it is cleared from memory. "dynamic" is for something
        -- like MFA codes which change every time.
        ssh_prompts = {
          {
            match = "password:",
            type = "secret",
            input_prompt = "Enter password: ",
            value_type = "static",
            value = "",
          },
          {
            match = "continue connecting (yes/no/[fingerprint])?",
            type = "plain",
            input_prompt = "Do you want to continue connection (yes/no)? ",
            value_type = "static",
            value = "",
          },
        },
      },
      -- Installation script location on local machine (If you have your own custom
      -- installation script and you do not want to use the packaged install script.
      -- It should accept the same inputs as the packaged install script though)
      neovim_install_script_path = util.path_join(util.is_windows,
        util.get_package_root(), "scripts", "neovim_install.sh"),
      -- Where should everything that Remote Neovim does on remote be stored. By
      -- default, it stores everything inside ~/.remote-nvim so as long as you
      -- delete that folder, you essentially wipe out everything that remote-nvim
      -- has over there.
      remote_neovim_install_home = util.path_join(util.is_windows, "~", ".remote-nvim"),
      -- Where is your personal Neovim config stored?
      neovim_user_config_path = vim.fn.stdpath("config"),
      local_client_config = {
        -- modify this function to override how your client launches
        -- function should accept two arguments function(local_port, workspace_config)
        -- local_port is the port on which the remote server is available locally
        -- workspace_config contains the workspace config. For all attributes present
        -- in it, see WorkspaceConfig in ./lua/remote-nvim/config.lua.
        -- See examples of callback in https://github.com/amitds1997/remote-nvim.nvim/wiki/Configuration-recipes
        callback = nil,
        -- [Subject to change]: These values may be subject to change, so there
        -- might be a breaking change. Right now, it uses the [plenary.nvim#win_float.percentage_range_window](https://github.com/nvim-lua/plenary.nvim/blob/267282a9ce242bbb0c5dc31445b6d353bed978bb/lua/plenary/window/float.lua#L138C25-L138C25)
        default_client_config = {
          col_percent = 0.9,
          row_percent = 0.9,
          win_opts = {
            winblend = 5,
          },
          border_opts = {
            topleft = "╭",
            topright = "╮",
            top = "─",
            left = "│",
            right = "│",
            botleft = "╰",
            botright = "╯",
            bot = "─",
          },
        },
      },

    }
  }
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
