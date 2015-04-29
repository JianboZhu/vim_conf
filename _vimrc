" common_conf {
set smarttab
set encoding=utf-8
set showcmd
set incsearch
set nobackup
set nocompatible
set statusline+=%f\
set autoindent
set showmatch
set ruler
set softtabstop=2
set cindent
set nobackup
set history=1000
set ai
set smartindent
set laststatus=2
set expandtab
set shiftwidth=2
set tabstop=2
set cursorline
set nu
set autoread
"set mouse=a
"set ignorecase
set hlsearch
set helplang=cn
"set foldmethod=indent
" }  // end common_conf

syntax enable
syntax on

"filetype off
colorscheme desert

set guifont=Consolas:h14:cANSI

au BufRead,BufNewFile *.h,*.c,*.cpp,*.py,*.cs,*.csproj,*.xml 2match Underlined /.\%81v/

"set colorcolumn=81

" Remove the tailing spaces by entering "cS" in the regular mode
nmap cS :%s/\s\+$//g<cr>:noh<cr>
" Remove the tailing "^M" by entering "cM" in the regular mode
nmap cM :%s/\r$//g<cr>:noh<cr>

" Highlight operators and parentheses
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()


" ========================== Vundle settings Begin ==================================

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/bundle/Vundle.vim/
let path='~/bundle'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" powerline_conf {
Bundle 'Lokaltog/vim-powerline'
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'
" }  // end powerline_conf

" taglist_conf {
Bundle 'taglist.vim'
let Tlist_Show_One_File = 1                                "  只显示当前文件的taglist，默认是显示多个
let Tlist_Exit_OnlyWindow = 1                              "  如果taglist是最后一个窗口，则退出vim
let Tlist_Auto_Open = 1                                    "  启动VIM后自动打开taglist窗口
let Tlist_Use_Right_Window = 1                             "  在右侧窗口中显示taglist
let Tlist_GainFocus_On_ToggleOpen = 0                      "  打开taglist时，光标保留在代码窗口
let Tlist_File_Fold_Auto_Close=1
let Tlist_Ctags_Cmd='/usr/bin/ctags '                      "  设置ctags命令的位置
" 设置关闭和打开taglist窗口的快捷键
nnoremap <leader>tl : Tlist<CR>
" } // end taglist_conf

" switch between .h and .cc files using the command, ':A'
Bundle 'a.vim'
" Change the template in 'c-support/template'
Bundle 'c.vim'

" function: highlight the trailing space in red color.
" CMD: Use 'FixWhitespace' to remove the trailing space.
Bundle 'trailing-whitespace'

Bundle 'altercation/vim-colors-solarized'

Bundle 'godlygeek/tabular'

Bundle 'scrooloose/nerdtree'
let NERDTreeShowBookmarks=1

Bundle 'cSyntaxAfter'

" search and replace across mutiple files.
Bundle "EasyGrep"

" Manage windows of vim.
"Bundle 'winmanager'
"" let g:winManagerWindowLayout='FileExplorer|BufExplorer'
"let g:winManagerWindowLayout='FileExplorer|BufExplorer|TagList'
"let g:persistentBehaviour=0
"let g:winManagerWidth=20
"let g:defaultExplorer=1
""nmap <silent> <leader>fir :FirstExplorerWindow<cr>
""nmap <silent> <leader>bot :BottomExplorerWindow<cr>
"nmap <silent> <leader>wm :WMToggle<cr>

Bundle 'scrooloose/nerdcommenter'

Bundle 'breestealth/Mark-Karkat'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ============================ Vundle setting end ==========================================


"set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
