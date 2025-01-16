return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "texlab" } },
  },
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable "pplatex" == 1 and "pplatex" or "latexlog"
      -- vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
      vim.g.maplocalleader = " "
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "vimtex#fold#level(v:lnum)"
      vim.o.foldtext = "vimtex#fold#text()"
      vim.o.foldlevel = 2
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- optional = true,
    config = function()
      require("lspconfig").texlab.setup {
        on_attach = require("configs.lspconfig").on_attach,
        capabilities = require("configs.lspconfig").capabilities,
      }
      vim.keymap.set(
        { "n" },
        "<leader>K",
        "<plug>(vimtex-doc-package)",
        { silent = true, desc = "Switch Source/Header (C/C++)" }
      )
    end,
  },
}
