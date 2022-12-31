" Base in Configurations from 'https://github.com/neoclide/coc-snippets',
" 'https://github.com/neoclide/coc.nvim/' and other sites.


" Signature Help of function 
set updatetime=1000
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')


" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
" The second line is used for spelling autocomplete. Isn't a default coc-nvim configuration.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: Is_spelling() ? Set_spelling_var(0)."\<UP>\<C-N>\<LEFT>\<RIGHT>"
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Snippet navegation
let g:coc_snippet_prev = '<s-tab>'
let g:coc_snippet_next = '<tab>'
