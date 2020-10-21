""""""""""";;; INIT.VIM ;;;"""""""""""



set encoding=utf-8
set fileencoding=utf-8

set backup
set undofile

set hidden
set signcolumn=yes
set mouse=a

filetype plugin on
let mapleader = "\\"

set number
set cursorline

set hls
set hlsearch

set tabstop=4
set shiftwidth=4
set noexpandtab

set list
set listchars=tab:𝅙𝅙⎜



""" Maps

nmap <silent> <F1>  : tabp <CR>
nmap <silent> <F2>  : tabn <CR>
 
nmap <silent> <F3>  : NERDTree <CR>
nmap <silent> <F4>  : Files <CR>
 
nmap <C-F>          : %s///g<left><left><left>
vmap <C-F>          : s///g<left><left><left>
 
nmap <S-TAB>        : '<,'>s/^\t//g <Enter>
nmap <TAB>          : '<,'>s/^/\t/g <Enter>
vmap <S-TAB>        : s/^\t//g <Enter>
vmap <TAB>          : s/^/\t/g <Enter>
 
nmap <C-X>           <ESC>'<V'>
map <silent> <C-C>  : w !xclip -i -selection clipboard <Enter><Enter>

 
 
""" Configure cursor appearance

if exists('$TMUX')
	let &t_SI = "\ePtmux;\e\e[6 q\e\\"
	let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
	let &t_SI = "\e[6 q"
	let &t_EI = "\e[2 q"
endif



" Vim-Plug

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	!sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'adelarsq/vim-matchit'
Plug 'preservim/tagbar'
Plug 'romgrk/winteract.vim'
Plug 'AnotherProksY/ez-window'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colorschemes
Plug 'vim-airline/vim-airline-themes'
Plug 'ParamagicDev/vim-medic_chalk'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'cseelus/vim-colors-lucid'

call plug#end()



""" Configure color schemes

syntax enable

set background=dark

" Fix terminal colors
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Configure edge colorscheme
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1

" Configure sonokai colorscheme
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai

"" Fixing colorchemes
if g:colors_name == "github"
	autocmd VimEnter * :hi airline_tab guifg=#ffffff guibg=#6a737d
endif



""" Configure COC

let g:coc_global_extensions = [
			\ 'coc-json',
			\ 'coc-snippets',
			\ 'coc-prettier',
			\ 'coc-eslint'
			\ ]


"" Functions

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction


"" Groups

augroup mygroup
autocmd!
	" Setup formatexpr specified filetype(s)
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


"" Maps

" Tab trigger completion
inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ?
	\ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

" Change snippet
let g:coc_snippet_next = '<tab>'

" Tab trigger completion
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" C-Space trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Enter select the first completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Code diagnostic
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor
set updatetime=500
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


"" Mappings for CoCList

" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>

" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>

" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>

" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



""" Configure vim-arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino



""" Configure Syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



""" Configure YouCompleteMe

let g:ycm_show_diagnostics_ui = 0   " Turning off the default syntax correction



""" Configure autopairs

let g:AutoPairsShortcutToggle = '<F5>'
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''



""" Configure Vim-airline

" Fonts
let g:airline_powerline_fonts = 1

" Ailine
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_alt_sep = ''

" Tabline
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''



""" Configure NerdTree

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = ''
let NERDTreeIgnore = []



""" Configure NerdTree git Plugin

let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
				\ 'Modified'  :'✹',
				\ 'Staged'    :'',
				\ 'Untracked' :'',
				\ 'Renamed'   :'🢚',
				\ 'Unmerged'  :'',
				\ 'Deleted'   :'',
				\ 'Dirty'     :'•',
				\ 'Ignored'   :'',
				\ 'Clean'     :'✔︎',
				\ 'Unknown'   :'?',
				\ }



""" Configure Vim-Devicons

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1



""" Configure Easy-align

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:easy_align_ignore_groups = ['Comment', 'String']
let g:easy_align_ignore_unmatched = 1



""" Configure Tagbar

let g:tagbar_width = 30
autocmd VimEnter * :TagbarToggle

map <F8>     :TagbarToggle <CR>
map <F6>     :TagbarOpen fj <CR>



""" Configure winteract

nmap gw      :InteractiveWindow<CR>



""" Source '.vim/local_vimrc'

if filereadable(".vim/local_vimrc")
	source .vim/local_vimrc
endif



""" Source '.local_vimrc'

if filereadable(".local_vimrc")
	source .local_vimrc
endif


""" Useful commands

" let g:syntastic_c_include_dirs = ['./libraries/MyLibs/include']
