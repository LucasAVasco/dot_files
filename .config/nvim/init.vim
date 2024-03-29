""" Neo vim main configuration file.
"
" I didn't configure everything myself.
" Many settings are default for vim and I just used them.


" Source local vim configuration files
function! s:source_local_config()
	if filereadable(".vim/local_vimrc")
		source .vim/local_vimrc
	endif

	if filereadable(".local_vimrc")
		source .local_vimrc
	endif
endfunction


""" Common information

let g:first_file_extension = expand("%:e")


""" Sources local vim configuration files

let g:before_vimrc = v:true
let g:after_vimrc = v:false

call s:source_local_config()


""" Common files configurations

set encoding=utf-8
set fileencoding=utf-8
set backup
set undofile
set swapfile

silent !mkdir -p ~/.nvim/.backup_files/ ~/.nvim/.undo_files/ ~/.nvim/.swap_files/
set backupdir=~/.nvim/.backup_files//
set undodir=~/.nvim/.undo_files//
set directory=~/.nvim/.swap_files//

" Mouse configurations
set hidden
set signcolumn=yes
set mouse=a

" Load the plugin files for specific file types
filetype plugin on

" Indentation
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" 'Tab' character
set list
set listchars=tab:𝅙𝅙╎
" Alternatives -> ⎜╏┇┋┆┊

" Other configurations
set number
set cursorline
set hlsearch

" Maps
source ~/.config/nvim/maps.vim


""" Configures cursor appearance

if exists('$TMUX')
	let &t_SI = "\ePtmux;\e\e[6 q\e\\"
	let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
	let &t_SI = "\e[6 q"
	let &t_EI = "\e[2 q"
endif


""" Cursor motion

function SetProse(bool)
	" Treats file like prose
	if a:bool == "y"
		nmap <Up> g<Up>
		vmap <Up> g<Up>
		nmap <Down> g<Down>
		vmap <Down> g<Down>

		nmap j gj
		vmap j gj
		nmap k gk
		vmap k gk

		set linebreak

	" Treats file like code
	elseif a:bool == "n"
		nunmap <Up>
		vunmap <Up>
		nunmap <Down>
		vunmap <Down>

		nunmap j
		vunmap j
		nunmap k
		vunmap k

		set nolinebreak

	else
		echo "There is no such option!"
	endif
endfunction

command! -nargs=1 SetProse call SetProse(<q-args>)


""" Vim-Plug configuration

" When opening Neovim for the first time
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	!sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

if empty(glob('~/.nvim/plugged'))
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
" Plug 'vim-syntastic/syntastic'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'adelarsq/vim-matchit'
Plug 'preservim/tagbar'
Plug 'romgrk/winteract.vim'
Plug 'AnotherProksY/ez-window'
Plug 'preservim/vim-wordy'
Plug 'LucasAVasco/nvim-grammar-comment'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

" Colorschemes
Plug 'vim-airline/vim-airline-themes'
Plug 'ParamagicDev/vim-medic_chalk'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'cseelus/vim-colors-lucid'
Plug 'cocopon/iceberg.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'bluz71/vim-moonfly-colors'
Plug 'sickill/vim-monokai'
Plug 'franbach/miramare'
Plug 'rakr/vim-colors-rakr'
Plug 'danilo-augusto/vim-afterglow'
Plug 'rafalbromirski/vim-aurora'
Plug 'alessandroyorba/sierra'
Plug 'AlessandroYorba/Breve'
Plug 'AlessandroYorba/Alduin'
Plug 'romainl/apprentice'
Plug 'fabi1cazenave/kalahari.vim'
Plug 'pacokwon/onedarkpaco.vim'
Plug 'joshdick/onedark.vim'
Plug 'fenetikm/falcon'

call plug#end()


""" Configures color schemes

syntax enable

colorscheme monokai

set background=dark

let g:afterglow_inherit_background=1

" Fixes terminal colors
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Configures edge colorscheme
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1

" Configures sonokai colorscheme
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1

" Fixes colorchemes
if g:colors_name == "github"
	autocmd VimEnter * :hi airline_tab guifg=#ffffff guibg=#6a737d
endif

if g:colors_name == "alduin"
	autocmd VimEnter * :hi String guibg=a
endif

if g:colors_name == "onedarkpaco"
	let g:airline_theme="onedark"
endif


" Enables italics in comments
highlight Comment cterm=italic gui=italic

" If it doesn't work
set t_ZH=[3m
set t_ZR=[23m


" Changes Whitespace foreground colors
highlight Whitespace ctermfg=240 guifg=#585858


""" Whitespace errors

highlight WhitespaceError ctermbg=red guibg=red
autocmd BufWinEnter * match WhitespaceError /\s\+$/     " Highlight trailing whitespace
autocmd BufWinEnter * 2match WhitespaceError /\ \+\t/   " Highlight spaces before tabs


""" C like comments in JSON files

autocmd FileType json syntax match Comment +\/\/.\+$+


""" COC configurations

let g:coc_global_extensions = [
			\ 'coc-json',
			\ 'coc-snippets',
			\ 'coc-prettier',
			\ 'coc-eslint',
			\ 'coc-html',
			\ 'coc-css',
			\ 'coc-tsserver',
			\ 'coc-python'
			\ ]

source ~/.config/nvim/basic_coc_config.vim
source ~/.config/nvim/other_coc_config.vim

" Prettier
command! -nargs=0 CocPrettier :CocCommand prettier.forceFormatDocument

" Disables possible warning on startup for old vim/node version.
" This setting is here because some features may behave incorrectly and
" this option hides this.
let g:coc_disable_startup_warning = 1


""" Configures vim-arduino

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino


""" NerdCommenter

let g:NERDSpaceDelims = 1


""" Ale

let g:ale_linters = {"cpp": ["ccls"], "c": ["ccls"]}
let g:ale_open_list = 1
let g:ale_list_window_size = 10
" let g:ale_keep_list_window_open = 1
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'

" let g:ale_floating_preview = 1
" let g:ale_detail_to_floating_preview = 1
" let g:ale_hover_to_floating_preview = 1
" let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '   %linter%  -->  %s   %severity%'


""" C and C++

let g:stdc_version = get(g:, "stdc_version", "gnu17")
let g:stdcpp_version = get(g:, "stdcpp_version", "gnu++17")

let $STDC_VERSION=g:stdc_version
let $STDCPP_VERSION=g:stdcpp_version

" Standart send to ccls
let g:std_to_ccls = get(g:, "std_to_ccls", g:stdcpp_version)

if index(["c", "h"], g:first_file_extension) >= 0
	" Is a 'c' file
	let g:std_to_ccls = g:stdc_version

else
	" Is not a 'c' file. Consider that it is a 'c++' file
	let g:std_to_ccls = g:stdcpp_version
endif

let $STD_TO_CCLS=g:std_to_ccls

" libstdc++ version
let g:libstdcpp_version = glob("/usr/include/c++/*")
let g:libstdcpp_version = substitute(g:libstdcpp_version, ".*/", '', 'g')  " Removes /usr/include/c++/
let $LIBSTDCPP_VERSION=g:libstdcpp_version

let g:ale_c_ccls_init_options = {
			\	"cache": {
			\		"directory": "/tmp/ccls-cache1",
			\	},
			\	"clang": {
			\		"extraArgs": [
			\			"-std=" . g:stdc_version
			\		]
			\	}
			\ }

let g:ale_cpp_ccls_init_options = {
			\	"cache": {
			\		"directory": "/tmp/ccls-cache1",
			\	},
			\	"clang": {
			\		"extraArgs": [
			\			"-std=" . g:stdcpp_version,
			\			"-I/usr/include/c++/" . g:libstdcpp_version,
			\			"-I/usr/include/x86_64-linux-gnu/c++/" . g:libstdcpp_version
			\		]
			\	}
			\ }


""" Autopairs

let g:AutoPairsShortcutToggle = '<F5>'
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''


""" Vim-airline

" Fonts
let g:airline_powerline_fonts = 1

" Airline
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_alt_sep = ''

" Tabline
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" Vim-airline integration
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#show_coc_status = 1
let g:airline#extensions#ale#enabled = 1


""" Codeium

set statusline+=\{…\}%3{codeium#GetStatusString()}
imap <M-.>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <M-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>


""" NerdTree

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = ''

" NerdTree git Plugin

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


""" Vim-devicons

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1


""" Easy-align

" let g:easy_align_ignore_groups = ['Comment', 'String']
let g:easy_align_ignore_groups = []
let g:easy_align_ignore_unmatched = 1


""" Tagbar

let g:tagbar_width = 30
autocmd VimEnter * :TagbarToggle
autocmd TabNewEntered * :TagbarToggle


""" Spell checking

set spelllang=en_us
set complete+=k
set dictionary=spell

" Local dictionaries
set dictionary+=.vim/local_dictionary
set dictionary+=.local_dictionary

" Local thesaurus
set thesaurus+=.vim/local_thesaurus
set thesaurus+=.local_thesaurus

let g:spelling_var = 0  " If spelling popup is active
function Is_spelling()
	return g:spelling_var
endfunction

function Set_spelling_var(value)
	let g:spelling_var = a:value
	return ''
endfunction


""" Sources local vim configuration files

let g:before_vimrc = v:false
let g:after_vimrc = v:true

call s:source_local_config()
