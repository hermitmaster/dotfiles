vim.api.nvim_set_keymap('n', '<localleader>a', '<cmd>Dispatch terraform -chdir="%:p:h" apply<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>d', '<cmd>Dispatch terraform -chdir="%:p:h" destroy<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>f', '<cmd>Dispatch! terraform -chdir="%:p:h" fmt<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>g', '<cmd>Dispatch! terraform -chdir="%:p:h" get<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>i', '<cmd>Dispatch! terraform -chdir="%:p:h" init<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>p', '<cmd>Dispatch terraform -chdir="%:p:h" plan<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>r', '<cmd>Dispatch! terraform -chdir="%:p:h" refresh<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>t', '<cmd>Dispatch terraform -chdir="%:p:h" taint<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>u', '<cmd>Dispatch terraform -chdir="%:p:h" untaint<CR>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<localleader>v', '<cmd>Dispatch terraform -chdir="%:p:h" validate<CR>', { noremap = true, silent = true } )

