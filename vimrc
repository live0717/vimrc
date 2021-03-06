"
" Personal preference .vimrc file
" Maintained by Vincent Driessen <vincent@datafox.nl>
"
" My personally preferred version of vim is the one with the "big" feature
" set, in addition to the following configure options:
"
"     ./configure --with-features=BIG
"                 --enable-pythoninterp --enable-rubyinterp
"                 --enable-enablemultibyte --enable-gui=no --with-x --enable-cscope
"                 --with-compiledby="Vincent Driessen <vincent@datafox.nl>"
"                 --prefix=/usr
"
" To start vim without using this .vimrc file, use:
"     vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
"

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/vimrc/vim/bundle directory
filetype off                    " force reloading *after* pathogen loaded
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on       " enable detection, plugins and indenting in one step

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing behaviour
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change the mapleader from \ to ,
let mapleader=","

set autoread
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
"    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
"    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set nolist                      " don't show invisible characters by default,
" but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
"    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
"    with 1-letter words (looks stupid)

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v
map <C-s> /

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding rules
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editor layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
"    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim behaviour
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden                      " hide buffers instead of closing them this
"    means that the current buffer can be put
"    to background without being written; and
"    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
" quickfix window instead of opening new
" buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/vimrc/vim/undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
"    who did ever restore from swap files anyway?
set directory=~/vimrc/vim/tmp,~/tmp,/tmp
" store swap files in one of these directories
"    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
"    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
"    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
"    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)
"set ttyfast                     " always use a fast terminal
set cursorline                  " underline the current line, for quick orientation

" Tame the quickfix window (open/close using ,f)
"nmap <silent> <leader>f :QFix<CR>

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &t_Co > 2 || has("gui_running")
    syntax on                    " switch syntax highlighting on, when the terminal has colors
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcut mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, since we don't have to press that annoying Shift key that
" slows the commands down
"nnoremap ; :

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>q! :q!<CR>
nnoremap <leader>qa! :qa!<CR>

" Use Q for formatting the current paragraph (or visual selection)
vmap Q gq
nmap Q gqap

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Shortcut to make
nmap mk :make<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Use the damn hjkl keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Fast saving
nmap <leader>w :w!<cr>

func! MySys()
    return 'linux'
endfunc

if MySys() == "windows"
    " Fast editing of the .vimrc
    map <leader>e :e! ~/vimrc/vimrc<cr>

    " When vimrc is edited, reload it
    autocmd! bufwritepost vimrc source ~/vimrc/vimrc
else
    " Fast editing of the .vimrc
    map <leader>e :e! ~/vimrc/vimrc<cr>

    " When vimrc is edited, reload it
    autocmd! bufwritepost vimrc source ~/vimrc/vimrc
endif
" Easy window navigation

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" NOTICE: Really useful!

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Some useful keys for vimgrep
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

"
" From an idea by Michael Naumann
"
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""
" => Command mode related
""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d c <C-\>eCurrentFileDir("e")<cr>
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

:command! -nargs=+ Calc :py print <args>
:py from math import *

" Command-line mode keymappings:"{{{
" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
" <C-y>: paste.
cnoremap <C-y>          <C-r>*
" <C-s>: view history.
cnoremap <C-s>          <C-f>
" <C-l>: view completion list.
cnoremap <C-l>          <C-d>
" <A-b>, W: move to previous word.
cnoremap <A-b>          <S-Left>
" <A-f>, B: move to next word.
cnoremap <A-f>          <S-Right>
cnoremap <S-TAB>        <C-p>
" <C-g>: decide candidate.
cnoremap <C-g>          <Space><C-h>
" <C-t>: insert space.
cnoremap <C-t>          <Space>
"}}}

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

func! Cwd()
    let cwd = getcwd()
    return "e " . cwd
endfunc

func! DeleteTillSlash()
    let g:cmd = getcmdline()
    if MySys() == "linux" || MySys() == "mac"
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    endif
    if g:cmd == g:cmd_edited
        if MySys() == "linux" || MySys() == "mac"
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        endif
    endif
    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>bb :b#<cr>
map <C-X>b :b#<cr>
map <C-X><C-F> :e %:p:h

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew! %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" new tab
nnoremap <C-t>     :tabnew<cr>
vnoremap <C-t>     <C-C>:tabnew<cr>
inoremap <C-t>     <C-C>:tabnew<cr>
"tab left
"nnoremap <C-h>     :tabprevious<cr>
"vnoremap <C-h>     <C-C>:tabprevious<cr>
"inoremap <C-h>     <C-O>:tabprevious<cr>
"nnoremap <C-S-tab> :tabprevious<cr>
"vnoremap <C-S-tab> <C-C>:tabprevious<cr>
"inoremap <C-S-tab> <C-O>:tabprevious<cr>
"tab right
"nnoremap <C-l>     :tabnext<cr>
"vnoremap <C-l>     <C-C>:tabnext<cr>
"inoremap <C-l>     <C-O>:tabnext<cr>
"nnoremap <C-tab>   :tabnext<cr>
"vnoremap <C-tab>   <C-C>:tabnext<cr>
"inoremap <C-tab>   <C-O>:tabnext<cr>
"tab indexes
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
noremap <A-9> 9gt
noremap <A-0> 10gt

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Specify the behavior when switching between buffers
try
    set switchbuf=usetab
    set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i


""""""""""""""""""""""""""""""
" => General Abbrevs
""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

""""""""""""""""""""""""""""""
" => Editing mapping
""""""""""""""""""""""""""""""
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


if MySys() == "mac"
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t


" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Quick yanking to the end of the line
nmap Y y$

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" YankRing stuff                           //
let g:yankring_history_dir = '~/vimrc/vim/.tmp'
nmap <leader>r :YRShow<CR>


" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

" Quick alignment of text
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Scratch
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Folding
nnoremap <Space> za
vnoremap <Space> za

" Strip all trailing whitespace from a file, using ,w
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Run Ack fast
nnoremap <leader>a :Ack<Space>

" Creating folds for tags in HTML
"nnoremap <leader>ft Vatzf

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" Gundo.vim
nnoremap <F5> :GundoToggle<CR>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neocomplcache config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length            = 3

let g:neocomplcache_lock_buffer_name_pattern     = '\*ku\*'

let g:neocomplcache_snippets_dir =  '~/vimrc/vim/my/snippets'



" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
""inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Conflict markers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => trinity settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap <leader>n :TrinityToggleAll<CR>
"nmap <leader>nl :TrinityToggleNERDTree<CR>
"nmap <leader>nr :TrinityToggleTagList<CR>
"nmap <leader>nd :TrinityToggleSourceExplorer<CR>
nmap <leader>nn :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype specific handling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype html,htmldjango let b:closetag_html_style=1

        autocmd filetype html,xhtml,xml source ~/vimrc/vim/scripts/closetag.vim
    augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()
        autocmd filetype python let $WORKON_HOME=fnamemodify("~/workon",":p")

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=80
        "autocmd filetype python match ErrorMsg '\%>80v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Run a quick static syntax check every time we save a Python file
        "autocmd BufWritePost *.py call Pyflakes()
    augroup end " }}}

    augroup ruby_files "{{{
        au!

        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Skeleton processing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")

    "    if !exists('*LoadTemplate')
    "    function LoadTemplate(file)
    " Add skeleton fillings for Python (normal and unittest) files
    "        if a:file =~ 'test_.*\.py$'
    "            execute "0r ~/vimrc/vim/skeleton/test_template.py"
    "        elseif a:file =~ '.*\.py$'
    "            execute "0r ~/vimrc/vim/skeleton/template.py"
    "        endif
    "    endfunction
    "    endif

endif " has("autocmd")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Restore cursor position upon reopening files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Common abbreviations / misspellings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/vimrc/vim/autocorrect.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra vi-compatibility
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set extra vi-compatible options
set cpoptions+=$     " when changing a line, don't redisplay, but put a '$' at
" the end during the change
set formatoptions-=o " don't start new lines w/ comment leader on pressing 'o'
au filetype vim set formatoptions-=o
" somehow, during vim filetype detection, this gets set
" for vim files, so explicitly unset it again

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra user or machine specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/vimrc/vim/user.vim

" Creating underline/overline headings for markup languages
" Inspired by http://sphinx.pocoo.org/rest.html#sections
nnoremap <leader>1 yyPVr=jyypVr=
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

"if has("gui_running")
set guifont=Monaco\ 10
"colorscheme baycomb
"colorscheme mustang
colorscheme molokai

" Remove toolbar, left scrollbar and right scrollbar
"set guioptions-=T
"set guioptions-=l                          G
"set guioptions-=L
"set guioptions-=r
"set guioptions-=R
set go=
" Screen recording mode
function! ScreenRecordMode()
    set columns=86
    set guifont=Monaco\ 11
    set cmdheight=1
    colorscheme molokai_deep
endfunction
command! -bang -nargs=0 ScreenRecordMode call ScreenRecordMode()
"endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimClojure
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "~/vimrc/vim/bundle/vimClojureLib/vimclojure-nailgun-client/ng"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tabular
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" idea from  http://vimcasts.org/episodes/aligning-text-with-tabular-vim

" temp diabled for conflicts
"if exists(":Tabularize")
  "nmap <Leader>a= :Tabularize /=<CR>
  "vmap <Leader>a= :Tabularize /=<CR>
  "nmap <Leader>a: :Tabularize /:\zs<CR>
  "vmap <Leader>a: :Tabularize /:\zs<CR>
"endif


"inoremap <silent> = =<Esc>:call <SID>ealign()<CR>a
"function! s:ealign()
  "let p = '^.*=.*$'
  "if exists(':Tabularize') && getline('.') =~# '^.*[=]' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    "let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
    "let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
    "Tabularize/=/l1
    "normal! 0
    "call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  "endif
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_auto_loc_list=1
"sudo pip install pyflakes
"sudo apt-get install tidy


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FuzzyFinder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>t :FuzzyFinderTextMate<CR>
"let g:fuf_modesDisable = ['mrucmd',]
"nnoremap <leader>fb :FufBuffer<CR>
"nnoremap <leader>fr :FufFile<CR>
"nnoremap <leader>ff :FufCoverageFile<CR>
"nnoremap <leader>fd :FufDir<CR>
"nnoremap <leader>fm :FufMruFile<CR>
"nnoremap <leader>fh :FufHelp<CR>
"nnoremap <leader>fl :FufLine<CR>

let g:ctrlp_map = '<leader>ff'
let g:ctrlp_working_path_mode = "ra"
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_extensions = ['dir','line', 'changes', 'mixed', 'bookmarkdir']
nnoremap <leader>fb :CtrlPBuffer<CR>
nnoremap <leader>fr :CtrlPRoot<CR>
nnoremap <leader>ff :CtrlP<CR>
nnoremap <leader>fd :CtrlPDir<CR>   
nnoremap <leader>fm :CtrlPMRU<CR>
"nnoremap <leader>fh :FufHelp<CR>
nnoremap <leader>fl :CtrlPLine<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ScreenShell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:ScreenShellGnuScreenVerticalSupport = 'patch'

"nmap <leader>s :ScreenShellVertical<CR>
"nmap <leader>sp :ScreenShellVertical ipython<CR>
"nmap <leader>ss :ScreenSend<CR>
"nmap <leader>sq :ScreenQuit<CR>

"function! s:ScreenShellListener()
    "if g:ScreenShellActive
       "map <C-c><C-c> :ScreenSend<cr>
        "map <C-c><C-x> :ScreenQuit<cr>
    "else
        "map <C-c><C-c> :ScreenShell<cr>
    "endif
"endfunction

"map <C-c><C-c> :ScreenShell<cr>
"augroup ScreenShellEnter
    "autocmd User * call <SID>ScreenShellListener()
"augroup END
"augroup ScreenShellExit
    "autocmd User * call <SID>ScreenShellListener()
"augroup END
set novisualbell
