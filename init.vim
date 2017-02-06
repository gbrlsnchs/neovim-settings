if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $NVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
" interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'mhinz/vim-startify'

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" omnicompletion
Plug 'Rip-Rip/clang_complete'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'Quramy/tsuquyomi', { 'depends': 'vimproc.vim' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'fatih/vim-go'

" others
Plug 'jiangmiao/auto-pairs'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-grepper'
Plug 'haya14busa/vim-operator-flashy', { 'depends': 'vim-operation-user' }
Plug 'kana/vim-operator-user'
Plug 'mtth/scratch.vim'
Plug 'vim-syntastic/syntastic'

" syntax
Plug 'leafgarland/typescript-vim'
Plug 'jeroenbourgois/vim-actionscript'
Plug 'ernstvanderlinden/vim-coldfusion'
Plug 'ryanoasis/vim-devicons'
Plug 'mxw/vim-jsx'
Plug 'sheerun/vim-polyglot'
Plug 'hdima/python-syntax'
Plug 'vitalk/vim-shebang'
call plug#end()

if &compatible
    set nocompatible
endif

filetype plugin indent on
syntax enable

set hidden
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
set ttimeoutlen=50
set number
set bs=2
set columns=80
set textwidth=0
set wrapmargin=0
set ruler
set encoding=utf-8
set showtabline=2
set directory=~/.local/share/nvim/swapfiles
set t_Co=16
set nuw=7
set noshowmode
set showcmd
set background=dark
set pumheight=10
set nohlsearch
set omnifunc=syntaxcomplete#Complete
" set foldmethod=syntax

colorscheme solarized

command W execute 'w'
command Wq execute 'wq'
command WQ execute 'wq'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#show_message = 0

" NERDTree
let g:NERDTreeWinSize = 40

" Python Syntax
let python_highlight_all = 1 

" Solarized
let g:solarized_termcolors = 16

" Startify
let g:startify_change_to_dir = 0
let g:startify_session_dir = '~/.local/share/nvim/sessions'
let g:startify_relative_path = 1
let g:jsx_ext_required = 1

" tsuquyomi
let g:tsuquyomi_disable_quickfix = 1

" syntastic
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']
let g:term_map_keys = 1
let g:term_show_argument_hints = 'on_hold'
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:go_fmt_fail_silently = 1

" fzf
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }
" Default cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

augroup AutoSwap
    autocmd!
    autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
    " if swapfile is older than file itself, just get rid of it
    if getftime(v:swapname) < getftime(a:filename)
        call delete(v:swapname)
        let v:swapchoice = 'e'
    endif
endfunction

augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END

function! s:update_fzf_colors()
    let rules =
                \ { 'fg':      [['Normal',       'fg']],
                \ 'bg':      [['Normal',       'bg']],
                \ 'hl':      [['Comment',      'fg']],
                \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
                \ 'bg+':     [['CursorColumn', 'bg']],
                \ 'hl+':     [['Statement',    'fg']],
                \ 'info':    [['PreProc',      'fg']],
                \ 'prompt':  [['Conditional',  'fg']],
                \ 'pointer': [['Exception',    'fg']],
                \ 'marker':  [['Keyword',      'fg']],
                \ 'spinner': [['Label',        'fg']],
                \ 'header':  [['Comment',      'fg']] }
    let cols = []
    for [name, pairs] in items(rules)
        for pair in pairs
            let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
            if !empty(name) && code > 0
                call add(cols, name.':'.code)
                break
            endif
        endfor
    endfor
    let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
    let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
                \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
    autocmd!
    autocmd ColorScheme * call <SID>update_fzf_colors()
augroup END

augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

augroup gitcommit
    autocmd!
    autocmd FileType gitcommit set nobuflisted
augroup END

function s:RemapBuffers()
    if &l:buftype ==# 'nofile'
        set nobuflisted

        if !empty(mapcheck('<Tab>'))
            nunmap <Tab>
            nunmap <S-Tab>
            nunmap <C-w><F8>
            nunmap <C-w><F9>
        endif
    else
        nmap <silent> <Tab> :bn<CR>
        nmap <silent> <S-Tab> :bp<CR>
        nmap <silent> <C-w><F8> :Bd<CR>
        nmap <silent> <C-w><F9> :bd<CR>
    endif
endfunction

function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=234 ctermbg=136
    highlight fzf2 ctermfg=234 ctermbg=136
    highlight fzf3 ctermfg=234 ctermbg=136
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <S-f> :Grepper -tool rg -query ''<Left>
nmap <silent> <F8> :NERDTreeToggle <Bar> call <SID>RemapBuffers()<CR>
nmap <silent> <F9> :NERDTreeFind <Bar> call <SID>RemapBuffers()<CR>
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
nmap <silent> <C-p> :Files<CR>
cmap <C-p> <Up>
cmap <C-n> <Down>
inoremap <silent> <expr><Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
" inoremap <silent> <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <silent> <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
" inoremap <silent> <expr><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
            \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
autocmd FileType javascript nmap <silent> <C-]> :TernDef<CR>
autocmd! User FzfStatusLine call <SID>fzf_statusline()
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead .tern-project set filetype=json
autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
autocmd FileType java setlocal omnifunc=javacomplete#Complete tags+=~/.local/share/nvim/tags/java/jdk
autocmd FileType c setlocal tags+=~/.local/share/nvim/tags/c/headers,~/.local/share/nvim/tags/c/sdl
autocmd FileType cpp setlocal tags+=~/.local/share/nvim/tags/c++/headers,~/.local/share/nvim/tags/c/sdl
autocmd Bufread,BufNewFile *.cfm set filetype=eoz
autocmd Bufread,BufNewFile *.cfc set filetype=eoz

" prevent Startify from using absolute paths
autocmd! BufEnter * :lcd `pwd` | :syntax sync fromstart | :call <SID>RemapBuffers()
