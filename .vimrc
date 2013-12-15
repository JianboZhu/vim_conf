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
set history=1000            "设置历史记录条数
set ai                      "自动缩进
set smartindent
set laststatus=2            "总是显示状态行
set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=2
set tabstop=2
set cursorline              "为光标所在行加下划线
set nu                      "显示行号
set autoread                "文件在Vim之外修改过，自动重新读入
"set mouse=a                "设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
"set ignorecase             "检索时忽略大小写
set hlsearch                "检索时高亮显示匹配项
set helplang=cn             "帮助系统设置为中文
"set foldmethod=indent       "代码折叠
" }  // end common_conf

syntax enable
syntax on

syntax on
"filetype off
colorscheme desert
" vundle_conf {
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" }
" 注意，不要在Bundle命令后面添加注释，不然，会被误认为参数。并报以下错误：
" Invalid arguments for function vundle#config#bundle
Bundle 'gmarik/vundle'

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
"let Tlist_Auto_Open = 1                                    "  启动VIM后自动打开taglist窗口
let Tlist_Use_Right_Window = 1                             "  在右侧窗口中显示taglist
let Tlist_GainFocus_On_ToggleOpen = 1                      "  打开taglist时，光标保留在taglist窗口
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
syntax enable
set background=dark
colorscheme solarized

Bundle 'godlygeek/tabular'

Bundle 'scrooloose/nerdtree'
let NERDTreeShowBookmarks=1

Bundle 'cSyntaxAfter'

" search and replace across mutiple files.
Bundle "EasyGrep"

Bundle 'scrooloose/nerdcommenter'

Bundle 'breestealth/Mark-Karkat'

" conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
" tabs_conf {
let mapleader = ','
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>
" } // end tabs_conf

" 超过80行时，就用下划线标示出来
au BufRead,BufNewFile *.h,*.c,*.cpp,*.py 2match Underlined /.\%81v/

"set colorcolumn=81                                " 这条命令在81列的地方花一条挺粗的红线

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<cr>:noh<cr>
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<cr>:noh<cr>

" 高亮括号与运算符等
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()

" blade_conf {
augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end

function! Blade(...)
    let l:old_makeprg = &makeprg
    setlocal makeprg=blade
    execute "make " . join(a:000)
    let &makeprg=old_makeprg
endfunction

command! -complete=dir -nargs=* Blade call Blade('<args>')
" } // end balde_conf

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
