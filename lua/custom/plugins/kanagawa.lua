-- Kanagawa colorscheme - dragon variant (dark warm theme)
return {
  'rebelot/kanagawa.nvim',
  priority = 1000, -- Load before other plugins to ensure theme applies first
  init = function()
    -- Load the kanagawa-dragon colorscheme
    -- Other variants: 'kanagawa-wave' (default dark), 'kanagawa-lotus' (light)
    vim.cmd.colorscheme 'kanagawa-dragon'
    -- Optional: You can configure highlights here if needed
    -- Example: vim.cmd.hi 'Comment gui=none'
  end,
}
-- vim: ts=2 sts=2 sw=2 et
