" Character to use as leader
let mapleader = "\\"


" Navegation
nmap <silent> <F1>  : tabp <CR>
nmap <silent> <F2>  : tabn <CR>
nmap <silent> <F3>  : NERDTree <CR>
nmap <silent> <F4>  : Files <CR>
 
" Replacement
nmap <C-F>          : %s///g<left><left><left>
vmap <C-F>          : s///g<left><left><left>

" Indentation
nmap <S-TAB>        : '<,'>s/^\t//g <Enter> :/$\^ <Enter>
nmap <TAB>          : '<,'>s/^/\t/g <Enter> :/$\^ <Enter>
vmap <S-TAB>        : s/^\t//g <Enter> :/$\^ <Enter>
vmap <TAB>          : s/^/\t/g <Enter> :/$\^ <Enter>
 
" Select the last visual selection
nmap <C-X>           <ESC>'<V'>

" Copy to clipboard
nmap <silent> <C-C> : w !xclip -i -selection clipboard <Enter><Enter>
vmap <C-C>            "+y


""" Plugins

" Vim visual multi
let g:VM_leader = '\|'
nmap <C-LeftMouse> <LeftMouse>\|\\

" Easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Tagbar
map <F8>     :TagbarToggle <CR>
map <F6>     :TagbarOpen fj <CR>

" Winteract
nmap gw      :InteractiveWindow<CR>

" Coc-snippets: convert visual selected code to snippet
xmap <leader>ts  <Plug>(coc-convert-snippet)


""" OBS.: The default COC maps are in the '~/.config/nvim/basic_coc_config.vim' file.