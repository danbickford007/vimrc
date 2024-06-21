" Required bundles for this dotfile
" ack.vim                  ctrlp.vim                syntastic                vim-fugitive
" awesome-vim-colorschemes nerdtree                 vim-elixir               vim-ripgrep

execute pathogen#infect()

set viminfo="NONE"
filetype plugin indent on
syntax on

"delete 20 buffers
" map xxx :1,20bd<cr>
nnoremap <F5> :GundoToggle<CR>
syntax on
setf pegjs
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set number
set nowrap
set guifont=Monico
set hidden
map ,ln :set number<cr>
map ,nl :set nonumber<cr>
map ,t :w \|!rspec %<cr>
map ,<right> :bn<cr>
map ,<left> :bp<cr>
map ,a :Ack
map ,q :bd

function! s:ToggleBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        Git blame
    endif
endfunction

nnoremap ,b :call <SID>ToggleBlame()<CR>

map ,j  :%!jq .<cr>

"map ,b :Git blame<cr>
"

"spellcheck vim
setlocal spell spelllang=en_us

map ,c :w \|!cucumber<cr>
map ct :checktime<cr>
map ,rtf :CopyRTF<cr>
map ,op :call VimuxRunCommand('
colorscheme spacecamp
:cd %:p:h
set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

autocmd FileType ruby compiler ruby
no ,w <C-w><C-w>
map ,s <C-w><C-v><C-w><C-w>
map ,c :w\|:!cucumber features<cr>
map ,n :NERDTree<cr>
imap <Nul> <ESC>
imap jk <ESC>
imap kj <ESC>
imap <C-h> <C-W>
map <C-n> :tabnext<cr>
map <C-p> :tabprevious<cr>
map <C-t> :tabnew<cr>
map <C-c> :tabclose<cr>

let g:ctrlp_map = '\t'
let g:ctrlp_cmd = 'CtrlP'

map \t :CtrlP<cr>

nmap n nzz
nmap N Nzz
vnoremap ,c :s/^/#<cr>
vnoremap ,u :s/^#//<cr>
no J 8j
no K 8k
"set winwidth=104
"set winheight=5
"set winminheight=5
"set winheight=999
set wildmode=longest,list
set wildmenu
set nu
set viminfo='100,<50,s10,h,:100
set modeline
set ls=2

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vmap <silent>gg :call VisualSearch('gv')<CR>
vmap <silent>gd :call VisualSearch('gd')<CR>
map cc <C-_><C-_>

" Commenting blocks of code.
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> uc :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Ack " . l:pattern
    elseif a:direction == 'gd'
        execute "Ack \"(def|function|class) " . l:pattern . "\""
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

let g:syntastic_javascript_checkers = ['standard']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir
