local M = {}

M.sections = {
  lualine_a = {
    function()
      return 'MAN'
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

M.filetypes = { 'man' }

return M
