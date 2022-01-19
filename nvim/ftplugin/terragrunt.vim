map <buffer> <leader>ta :Dispatch  terragrunt apply -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>td :Dispatch  terragrunt destroy -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>tg :Dispatch  terragrunt get -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>ti :Dispatch! terragrunt init -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>tp :Dispatch  terragrunt plan -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>tr :Dispatch  terragrunt refresh -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>tt :Dispatch  terragrunt taint -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>tu :Dispatch  terragrunt untaint -terragrunt-working-dir "%:p:h"<cr>
map <buffer> <leader>tv :Dispatch! terragrunt validate -terragrunt-working-dir "%:p:h"<cr>

