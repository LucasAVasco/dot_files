" Character to use as leader
let mapleader = "\\"


" Navigation
nmap <silent> <F1>  : tabp <CR>
nmap <silent> <F2>  : tabn <CR>
nmap <silent> <F3>  : NERDTree <CR>
nmap <silent> <F4>  : Files <CR>
 
" Replacement
nmap <C-F>          : %s///g<left><left><left>
vmap <C-F>          : s///g<left><left><left>

" Indentation
nmap <S-TAB>        <ESC>'<V'><
nmap <TAB>          <ESC>'<V'>>
vmap <S-TAB>        <
vmap <TAB>          >
 
" Select the last visual selection
nmap <C-X>           <ESC>'<V'>

" Copy to clipboard
nmap <silent> <C-C> : w !xclip -i -selection clipboard <Enter><Enter>
vmap <C-C>            "+y

" Spelling
imap <expr> <C-D> Is_spelling() ? "\<C-N>" : Set_spelling_var(1)."\<C-X>\<C-K>"
imap <expr> <C-T> Is_spelling() ? "\<C-N>" : Set_spelling_var(1)."\<C-X>\<C-T>"
imap <expr> <ESC> Set_spelling_var(0)."\<ESC>"


""" Plugins

" Vim visual multi
let g:VM_leader = '\|'
nmap <C-LeftMouse> <LeftMouse>\|\\

" Easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Tag bar
map <F8>     :TagbarToggle <CR>
map <F6>     :TagbarOpen fj <CR>

" Winteract
nmap gw      :InteractiveWindow<CR>

" Coc-snippets: convert visual selected code to snippet
xmap <leader>ts  <Plug>(coc-convert-snippet)


""" OBS.: The default COC maps are in the '~/.config/nvim/basic_coc_config.vim' file.
