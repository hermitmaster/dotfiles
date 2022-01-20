map <buffer> <leader>ta :Dispatch -dir=%:p:h terragrunt apply<cr>
map <buffer> <leader>td :Dispatch -dir=%:p:h terragrunt destroy<cr>
map <buffer> <leader>tg :Dispatch -dir=%:p:h terragrunt get<cr>
map <buffer> <leader>ti :Dispatch! -dir=%:p:h terragrunt init<cr>
map <buffer> <leader>tp :Dispatch -dir=%:p:h terragrunt plan<cr>
map <buffer> <leader>tr :Dispatch -dir=%:p:h terragrunt refresh<cr>
map <buffer> <leader>tt :Dispatch -dir=%:p:h terragrunt taint<cr>
map <buffer> <leader>tu :Dispatch -dir=%:p:h terragrunt untaint<cr>
map <buffer> <leader>tv :Dispatch! -dir=%:p:h terragrunt validate<cr>

