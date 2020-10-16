" .CONFIG/NVIM/INIT.VIM 

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Recuperation
set backup
set undofile

" Pluggings
filetype plugin on

" MapLeader
let mapleader = "\\"



""" Personal configurations

" Lines and column
set number
set cursorline

" Search
set hls
set hlsearch

" Indentation
set tabstop=4
set shiftwidth=4
set noexpandtab

" List chars
set list
set listchars=tab:ꞏꞏ



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
Plug 'cormacrelf/vim-colors-github'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/forest-night'

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



" Configure vim-arduino
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



""" Configure SuperTab

let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc','&completefunc']
let g:SuperTabRetainCompletionType=2

inoremap <expr><Enter> pumvisible() ? "\<C-Y>" : "\<Enter>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"



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


""" Configure NerdTree git Plugin

let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
				\ 'Modified'  :'✹',
				\ 'Staged'    :'✚',
				\ 'Untracked' :'✭',
				\ 'Renamed'   :'➜',
				\ 'Unmerged'  :'═',
				\ 'Deleted'   :'✖',
				\ 'Dirty'     :'✗',
				\ 'Ignored'   :'☒',
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



""" Exec '.local_vimrc'

if filereadable(".local_vimrc")
	source .local_vimrc
endif


""" Useful commands

" let g:syntastic_c_include_dirs = ['./libraries/MyLibs/include']
