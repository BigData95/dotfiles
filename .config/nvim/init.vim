
call plug#begin()
Plug 'itchyny/lightline.vim' 
Plug 'preservim/nerdtree'
Plug 'justinmk/vim-sneak'
call plug#end()

""Manual installed
""vim-sorround

"lightline
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }


""nerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

""General
set number
set relativenumber

""Spell Check
set complete+=kspell

map <F9> :setlocal spell! spelllang=es <CR>
map <F8> :set spelllang=en_us<CR>
""set spell
""setlocal spell spelllang=es
set spellfile=~/.vim/dict_es.add


""" Move swap file so doesnt fuck with git
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
