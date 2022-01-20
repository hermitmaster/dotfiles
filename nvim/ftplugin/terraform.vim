map <buffer> <leader>ta :Dispatch -dir=%:p:h terraform -no-color apply<cr>
map <buffer> <leader>td :Dispatch -dir=%:p:h terraform -no-color destroy<cr>
map <buffer> <leader>tg :Dispatch! -dir=%:p:h terraform -no-color get<cr>
map <buffer> <leader>ti :Dispatch! -dir=%:p:h terraform -no-color init<cr>
map <buffer> <leader>tp :Dispatch -dir=%:p:h terraform -no-color plan<cr>
map <buffer> <leader>tr :Dispatch! -dir=%:p:h terraform -no-color refresh<cr>
map <buffer> <leader>tt :Dispatch -dir=%:p:h terraform -no-color taint<cr>
map <buffer> <leader>tu :Dispatch -dir=%:p:h terraform -no-color untaint<cr>
map <buffer> <leader>tv :Dispatch -dir=%:p:h terraform -no-color validate<cr>

