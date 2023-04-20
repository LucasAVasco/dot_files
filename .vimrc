" Developed by Lucas de Amorim Vasco



" Default configurations
source $VIMRUNTIME/defaults.vim

set encoding=utf-8
set fileencoding=utf-8

set backup
set undofile

filetype plugin on

let mapleader = "\\"



" Install and configure Vundle
if empty(glob('~/.vim/bundle/Vundle.vim/autoload/vundle.vim'))

	" Dowload repository
	!git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	" Fix code to better performance
	!sed 's/git clone/git clone --depth 1/g' ~/.vim/bundle/Vundle.vim/autoload/vundle/installer.vim > ~/.vim/bundle/Vundle.vim/autoload/vundle/installer.second && mv ~/.vim/bundle/Vundle.vim/autoload/vundle/installer.second ~/.vim/bundle/Vundle.vim/autoload/vundle/installer.vim

	!echo 'Remember to run ´:BundleInstall´'
endif



""" Personal configurations

set number
set cursorline

set hls
set hlsearch

set tabstop=4
set shiftwidth=4
set noexpandtab

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



" Plugins (Vundle)
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-surround'
Plugin 'preservim/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mg979/vim-visual-multi'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'ryanoasis/vim-devicons'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'adelarsq/vim-matchit'
Plugin 'preservim/tagbar'
Plugin 'romgrk/winteract.vim'
Plugin 'AnotherProksY/ez-window'
Plugin 'zxqfl/tabnine-vim'

""" Not more used Plugins
" Plugin 'ervandew/supertab'
" Plugin 'mattn/emmet-vim'

" Colorschemes
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'ParamagicDev/vim-medic_chalk'
Plugin 'cormacrelf/vim-colors-github'
Plugin 'sickill/vim-monokai'
Plugin 'sainnhe/edge'
Plugin 'sainnhe/sonokai'
Plugin 'sainnhe/forest-night'

""" Alternative Colorschemes
" Plugin 'jacoborus/tender.vim'
" Plugin 'nanotech/jellybeans.vim'
" Plugin 'sonph/onehalf', {'rtp': 'vim/'}
" Plugin 'chriskempson/base16-vim'
" Plugin 'artanikin/vim-synthwave84'
" Plugin 'gryf/wombat256grf'
" Plugin 'jcherven/jummidark.vim'
" Plugin 'relastle/bluewery.vim'
" Plugin 'tlhr/anderson.vim'


call vundle#end()           " required
filetype plugin indent on   " required
" Vundle (End)



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



""" Configure TabNine
inoremap <expr><Enter> pumvisible() ? "\<C-Y>" : "\<Enter>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"



""" Configure YouCompleteMe

let g:ycm_show_diagnostics_ui = 0   " Turning off the default syntax correction



""" Configure color schemes

syntax enable

set background=dark

" Fix terminal colors
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Edge colorscheme
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1

" Sonokai colorscheme
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai


"" Fixing colorchemes
if g:colors_name == "github"
	autocmd VimEnter * :hi airline_tab guifg=#ffffff guibg=#6a737d
endif



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
