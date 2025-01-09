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
lvim.keys.term_mode["<C-`>"] = "<C-\\><C-n>"

lvim.plugins = {
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "hrsh7th/nvim-cmp",
  { "folke/neodev.nvim", opts = {} },
  "nvim-telescope/telescope-live-grep-args.nvim",
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.builtin.which_key.mappings.s.t = {
  require('telescope').extensions.live_grep_args.live_grep_args, "Live grep args",
}
-- Show previewer when searching git files with default <leader>f
lvim.builtin.which_key.mappings["f"] = {
  require("lvim.core.telescope.custom-finders").find_project_files,
  "Find File"
}
-- Show previewer when searching buffers with <leader>bf
lvim.builtin.which_key.mappings.b.f = {
  "<cmd>Telescope buffers<cr>",
  "Find"
}

lvim.keys.insert_mode["<C-Space>"] = function()
  require('cmp').complete()
end
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "pyright"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- Add taplo to your LSP configurations
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "taplo"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- Configure taplo
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({
  {
    name = "taplo",
    filetypes = { "toml" },
  },
})

vim.opt.shell = "/opt/homebrew/bin/fish"

vim.keymap.set({ 'n', 't' }, '<C-1>', '<cmd>1ToggleTerm direction=float<CR>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<C-2>', '<cmd>2ToggleTerm direction=horizontal<CR>', { silent = true })


-- lvim.builtin.lualine.sections.lualine_c = {
--   {
--     'filename',
--     path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
--     file_status = true,
--     newfile_status = true,
--     shorting_target = 40,
--   }
-- }

-- local fmt_group = vim.api.nvim_create_augroup("LvimFormat", { clear = true })

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = fmt_group,
--   callback = function()
--     local buf_name = vim.api.nvim_buf_get_name(0)
--     local dir_to_exclude = vim.fn.expand("~/Code/vllm")

--     if not string.find(buf_name, dir_to_exclude) then
--       if vim.fn.exists(":LspFormatting") == 2 then
--         vim.cmd("LspFormatting")
--       elseif vim.fn.exists(":Format") == 2 then
--         vim.cmd("Format")
--       end
--     end
--   end,
-- })

-- -- Disable LunarVim's built-in format-on-save
-- lvim.format_on_save = false
