require('which-key').register({
  t = { name = 'terragrunt',
    a = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt apply') end, 'apply' },
    d = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt destroy') end, 'destroy' },
    g = { function () vim.cmd('Dispatch! -dir=%:p:h terragrunt get') end, 'get' },
    i = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt init') end, 'init' },
    p = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt plan') end, 'plan' },
    r = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt refresh') end, 'refresh' },
    t = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt taint') end, 'taint' },
    u = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt untaint') end, 'untaint' },
    v = { function () vim.cmd('Dispatch -dir=%:p:h terragrunt validate') end, 'validate' },
  }
}, { buffer = vim.api.nvim_buf_get_number(0), prefix = '<leader>' })
