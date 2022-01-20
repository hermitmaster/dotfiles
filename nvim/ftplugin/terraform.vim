map <buffer> <leader>ta :Dispatch  terraform -no-color -chdir="%:p:h" apply<cr>
map <buffer> <leader>td :Dispatch  terraform -no-color -chdir="%:p:h" destroy<cr>
map <buffer> <leader>tg :Dispatch! terraform -no-color -chdir="%:p:h" get<cr>
map <buffer> <leader>ti :Dispatch! terraform -no-color -chdir="%:p:h" init<cr>
map <buffer> <leader>tp :Dispatch  terraform -no-color -chdir="%:p:h" plan<cr>
map <buffer> <leader>tr :Dispatch! terraform -no-color -chdir="%:p:h" refresh<cr>
map <buffer> <leader>tt :Dispatch  terraform -no-color -chdir="%:p:h" taint<cr>
map <buffer> <leader>tu :Dispatch  terraform -no-color -chdir="%:p:h" untaint<cr>
map <buffer> <leader>tv :Dispatch  terraform -no-color -chdir="%:p:h" validate<cr>

