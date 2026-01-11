-- lua/custom/plugins/live-preview.lua
-- Plugin for live preview of Markdown, HTML, AsciiDoc, SVG in browser
-- See: https://github.com/brianhuster/live-preview.nvim
return {
  'brianhuster/live-preview.nvim',
  -- Lazy load on supported file types
  ft = { 'markdown', 'html', 'htm', 'asciidoc', 'svg' },
  dependencies = {
    -- Optional: Choose one picker for better UI
    -- 'nvim-telescope/telescope.nvim', -- Recommended if you use Telescope
    -- 'ibhagwan/fzf-lua',           -- Alternative: fzf-lua
    -- 'echasnovski/mini.pick',      -- Alternative: mini.pick
    'folke/snacks.nvim',
  },
  opts = {
    -- Port for the preview server (default: 5500)
    port = 5500,
    -- Sync scrolling: scroll browser as you scroll in Neovim (for markdown)
    sync_scroll = true,
    -- Browser to use for preview
    -- Set to nil to use system default, or specify: 'firefox', 'chrome', 'safari', etc.
    browser = nil,
    -- Dynamic root directory (useful for multi-file projects)
    dynamic_root = false,
    -- Picker
    picker = '',
  },
  config = function(_, opts)
    require('livepreview.config').set(opts)
    -- Keymaps for live preview
    -- NOTE: Commands use the pattern "LivePreview <subcommand>"
    vim.keymap.set('n', '<leader>lp', function()
      -- Start preview for current buffer
      vim.cmd('LivePreview start')
    end, { desc = '[L]ive [P]review start' })
    vim.keymap.set('n', '<leader>ls', '<cmd>LivePreview close<cr>', { desc = '[L]ive preview [S]top' })
    vim.keymap.set('n', '<leader>lf', '<cmd>LivePreview pick<cr>', { desc = '[L]ive preview pick [F]ile' })
    -- NOTE: For HTML files, preview updates on save, not on every change
    -- If you want auto-save for HTML files, uncomment this autocmd:
    -- vim.api.nvim_create_autocmd({ 'InsertLeavePre', 'TextChanged' }, {
    --   pattern = { '*.html', '*.htm' },
    --   callback = function()
    --     vim.cmd('silent! write')
    --   end,
    -- })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
