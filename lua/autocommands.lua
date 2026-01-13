-- [[ Autocommands ]]
-- See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Auto-save when leaving insert mode
-- Saves current buffer with notification
vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Auto-save file when leaving insert mode',
  group = vim.api.nvim_create_augroup('auto-save-insert', { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local buftype = vim.bo[buf].buftype
    local filetype = vim.bo[buf].filetype
    local filename = vim.api.nvim_buf_get_name(buf)

    -- List of filetypes/buftypes to exclude from auto-save
    local excluded_filetypes = {
      'neo-tree',
      'TelescopePrompt',
      'dashboard',
      'lazy',
      'mason',
      'help',
      'qf',
      'oil',
    }

    local excluded_buftypes = {
      'nofile',
      'prompt',
      'help',
      'quickfix',
      'terminal',
    }

    -- Check if filetype or buftype is excluded
    local is_excluded_filetype = vim.tbl_contains(excluded_filetypes, filetype)
    local is_excluded_buftype = vim.tbl_contains(excluded_buftypes, buftype)

    -- Check if buffer is modifiable, modified, has a filename, and is not excluded
    if vim.bo[buf].modifiable
        and vim.bo[buf].modified
        and filename ~= ''
        and not is_excluded_filetype
        and not is_excluded_buftype then
      -- Attempt to save
      local success, err = pcall(vim.cmd, 'write')

      if success then
        -- Show notification on successful save
        Snacks.notifier.notify('File saved: ' .. vim.fn.fnamemodify(filename, ':t'), 'info', {
          title = 'Auto-save',
          timeout = 1500, -- Show for 1.5 seconds
        })
      else
        -- Show error notification if save fails
        Snacks.notifier.notify('Failed to save: ' .. err, 'error', {
          title = 'Auto-save Error',
        })
      end
    end
  end,
})
-- vim: ts=2 sts=2 sw=2 et
