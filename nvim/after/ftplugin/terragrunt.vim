map <localleader>a :Dispatch terragrunt apply -terragrunt-working-dir "%:p:h"<cr>
map <localleader>c :Dispatch terragrunt console -terragrunt-working-dir "%:p:h"<cr>
map <localleader>d :Dispatch terragrunt destroy -terragrunt-working-dir "%:p:h"<cr>
map <localleader>g :Dispatch terragrunt get -terragrunt-working-dir "%:p:h"<cr>
map <localleader>h :Dispatch terragrunt graph -terragrunt-working-dir "%:p:h"<cr>
map <localleader>i :Dispatch! terragrunt init -terragrunt-working-dir "%:p:h"<cr>
map <localleader>o :Dispatch terragrunt output -terragrunt-working-dir "%:p:h"<cr>
map <localleader>p :Dispatch terragrunt plan -terragrunt-working-dir "%:p:h"<cr>
map <localleader>r :Dispatch terragrunt refresh -terragrunt-working-dir "%:p:h"<cr>
map <localleader>t :Dispatch terragrunt taint -terragrunt-working-dir "%:p:h"<cr>
map <localleader>u :Dispatch terragrunt untaint -terragrunt-working-dir "%:p:h"<cr>
map <localleader>v :Dispatch! terragrunt validate -terragrunt-working-dir "%:p:h"<cr>

