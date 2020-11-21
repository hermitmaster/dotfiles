" Key Mapping: {{{
map <localleader>a :Dispatch cd (dirname %) && terraform apply -auto-approve<CR>
map <localleader>c :Dispatch cd (dirname %) && terraform console<CR>
map <localleader>d :Dispatch cd (dirname %) && terraform destroy -auto-approve<CR>
map <localleader>f :Dispatch! cd (dirname %) && terraform fmt<CR>
map <localleader>g :Dispatch! cd (dirname %) && terraform get<CR>
map <localleader>h :Dispatch cd (dirname %) && terraform graph<CR>
map <localleader>i :Dispatch cd (dirname %) && terraform init<CR>
map <localleader>o :Dispatch cd (dirname %) && terraform output<CR>
map <localleader>p :Dispatch cd (dirname %) && terraform plan<CR>
map <localleader>r :Dispatch! cd (dirname %) && terraform refresh<CR>
map <localleader>t :Dispatch cd (dirname %) && terraform taint<CR>
map <localleader>u :Dispatch cd (dirname %) && terraform untaint<CR>
map <localleader>v :Dispatch cd (dirname %) && terraform validate<CR>
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker :
