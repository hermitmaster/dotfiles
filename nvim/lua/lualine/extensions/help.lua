local M = {}

M.sections = {
  lualine_a = {
    function()
      return 'HELP'
    end,
  },
  lualine_b = {
    {
      'filename',
      file_status = false
    }
  },
  lualine_z = {
    'progress'
  },
}

M.filetypes = { 'help' }

return M
