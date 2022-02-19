require('which-key').register({
  t = { name = 'terraform',
    a = { function () vim.cmd('Dispatch -dir=%:p:h terraform apply -no-color') end, 'apply' },
    d = { function () vim.cmd('Dispatch -dir=%:p:h terraform destroy -no-color') end, 'destroy' },
    g = { function () vim.cmd('Dispatch! -dir=%:p:h terraform get -no-color') end, 'get' },
    i = { function () vim.cmd('Dispatch -dir=%:p:h terraform init -no-color') end, 'init' },
    p = { function () vim.cmd('Dispatch -dir=%:p:h terraform plan -no-color') end, 'plan' },
    r = { function () vim.cmd('Dispatch -dir=%:p:h terraform refresh -no-color') end, 'refresh' },
    t = { function () vim.cmd('Dispatch -dir=%:p:h terraform taint -no-color') end, 'taint' },
    u = { function () vim.cmd('Dispatch -dir=%:p:h terraform untaint -no-color') end, 'untaint' },
    v = { function () vim.cmd('Dispatch -dir=%:p:h terraform validate -no-color') end, 'validate' },
  }
}, { buffer = vim.api.nvim_buf_get_number(0), prefix = '<leader>' })
