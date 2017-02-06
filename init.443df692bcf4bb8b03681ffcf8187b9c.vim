if empty(glob('~/.local/share/dein'))
    silent !curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
                \ && sh /tmp/installer.sh ~/.local/share/dein
    autocmd VimEnter * :call dein#install()
endif

if &compatible
    set nocompatible
endif
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.local/share/dein'))
    call dein#begin(expand('~/.local/share/dein'))
    call dein#add('vim-airline/vim-airline')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')
    call dein#add('scrooloose/nerdtree')
    call dein#add('mhinz/vim-startify')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('jeroenbourgois/vim-actionscript')
    call dein#add('cespare/dtd.vim')
    call dein#add('cespare/mxml.vim')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('moll/vim-bbye')
    call dein#add('hdima/python-syntax')
    call dein#add('mxw/vim-jsx')
    call dein#add('vitalk/vim-shebang')
    call dein#add('leafgarland/typescript-vim')
    call dein#add('neomake/neomake')
    call dein#add('mhinz/vim-grepper')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('kana/vim-operator-user')
    call dein#add('haya14busa/vim-operator-flashy')
    call dein#add('gsanches/coldfusion-utils')
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('carlitux/deoplete-ternjs')
    call dein#add('mhartington/nvim-typescript')
    call dein#add('mtth/scratch.vim')
    call dein#add('dracula/vim')

    call dein#end()
    call dein#save_state()
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
set directory=~/.config/nvim/swapfiles
set t_Co=16
set nuw=7
set noshowmode
set showcmd
set background=dark
set pumheight=10
set nohlsearch

colorscheme solarized

command W execute 'w'
command Wq execute 'wq'
command WQ execute 'wq'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#show_message = 0
" Neomake
let g:neomake_logfile = '/tmp/error.log'
" Grepper
" let g:grepper = {
"             \ 'dir': 'repo,file'
"             \ }
" NERDTree
let g:NERDTreeWinSize = 40
" Python Syntax
let python_highlight_all = 1 
" Solarized
let g:solarized_termcolors = 16
" Startify
let g:startify_change_to_dir = 0
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_relative_path = 1
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
" Deoplete Tern
let g:tern_request_timeout = 1
let g:tern#filetypes = [
            \ 'jsx',
            \ 'javascript.jsx',
            \ 'vue',
            \ 'js',
            \ 'javascript'
            \ ]
" echodoc
" let g:echodoc_enable_at_startup = 1
" jsx fix
let g:jsx_ext_required = 1
" tsuquyomi
" let g:tsuquyomi_disable_quickfix = 1
" syntastic
" let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']
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
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
            \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

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
        nmap <Tab> :bn<CR>
        nmap <S-Tab> :bp<CR>
        nmap <C-w><F8> :Bd<CR>
        nmap <C-w><F9> :bd<CR>
    endif
endfunction

" augroup nofile
"     autocmd!
"     autocmd BufEnter * call <SID>RemapBuffers()
" augroup END

function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=234 ctermbg=136
    highlight fzf2 ctermfg=234 ctermbg=136
    highlight fzf3 ctermfg=234 ctermbg=136
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

function! s:CheckTSConfigPath(cut_method)
    return getcwd() . '/' . substitute(system('echo ' . expand('%:.') . ' | cut -d "/" ' . a:cut_method), '\n\+$', '', '')
endfunction

function! s:GetTSConfigPath()
    let l:workspace_dir = s:CheckTSConfigPath('-f1')
    let l:src_dir = s:CheckTSConfigPath('-f1,2,3')

    if !empty(glob(l:workspace_dir . '/tsconfig.json'))
        return l:workspace_dir
    elseif !empty(glob(l:src_dir . '/tsconfig.json'))
        return l:src_dir
    else
        return getcwd()
    endif
endfunction

function! neomake#makers#ft#typescript#tsc()
    return {
                \ 'args': ['--project', <SID>GetTSConfigPath(), '--noEmit'],
                \ 'append_file': 0,
                \ 'errorformat':
                \   '%E%f %#(%l\,%c): error %m,' .
                \   '%E%f %#(%l\,%c): %m,' .
                \   '%Eerror %m,' .
                \   '%C%\s%\+%m'
                \ }
endfunction

nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <S-f> :Grepper -tool rg -query ''<Left>
nmap <silent> <F8> :NERDTreeToggle <Bar> call <SID>RemapBuffers()<CR>
nmap <silent> <F9> :NERDTreeFind<CR>
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
nmap <silent> <C-p> :Files<CR>
cmap <C-p> <Up>
cmap <C-n> <Down>
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd! User FzfStatusLine call <SID>fzf_statusline()
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead .tern-project set filetype=json
autocmd! FileType go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
autocmd! BufWritePost * :Neomake
" prevent Startify from using absolute paths
autocmd! BufEnter * :lcd `pwd` | :syntax sync fromstart | :call <SID>RemapBuffers()
