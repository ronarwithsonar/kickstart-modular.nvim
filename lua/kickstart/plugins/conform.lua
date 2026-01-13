return {
  { -- Autoformat
    'stevearc/conform.nvim',
    dependencies = {
      -- Auto-install formatters via Mason
      'williamboman/mason.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[C]ode [F]ormat',
      },
    },
    config = function()
      -- [[ Formatters to Auto-Install ]]
      -- List of formatters that should be automatically installed via Mason
      -- when setting up Neovim on a new machine. Add formatters here to ensure
      -- they're available without manual installation.
      local formatters_to_install = {
        'stylua', -- Lua formatter
        'prettierd', -- Fast Prettier daemon for markdown, yaml, json, etc.
      }

      -- [[ Auto-Install Formatters ]]
      -- Automatically install formatters listed above using mason-tool-installer
      require('mason-tool-installer').setup {
        ensure_installed = formatters_to_install,
      }

      -- [[ Configure Conform.nvim ]]
      -- Set up formatting behavior and formatters for each filetype
      require('conform').setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          local lsp_format_opt
          if disable_filetypes[vim.bo[bufnr].filetype] then
            lsp_format_opt = 'never'
          else
            lsp_format_opt = 'fallback'
          end
          return {
            timeout_ms = 500,
            lsp_format = lsp_format_opt,
          }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Markdown and YAML formatting with prettierd (faster daemon) or prettier (fallback)
          -- stop_after_first means: try prettierd first, use prettier only if prettierd unavailable
          markdown = { 'prettierd', 'prettier', stop_after_first = true },
          yaml = { 'prettierd', 'prettier', stop_after_first = true },
          -- Conform can also run multiple formatters sequentially
          -- python = { "isort", "black" },
          --
          -- You can use 'stop_after_first' to run the first available formatter from the list
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
