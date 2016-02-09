syntax on
let &t_Co=256
colorscheme molokai
set number
hi comment ctermfg=6
set background=dark

" Auto detect file type
filetype on

" Set tab space
set tabstop=2
set shiftwidth=2

" Create vimrc autocmd group and remove any existing vimrc autocmds,
" in case .vimrc is re-sourced.
augroup vimrc
  autocmd!
augroup END

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>


" When editing a file, always jump to the last known cursor position. Don't do
" it for commit messages, when the position is invalid, or when inside an event
" handler (happens when dropping a file on gvim).
autocmd vimrc BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Start vim-plug
call plug#begin('~/.vim/plugged')

Plug 'rodjek/vim-puppet'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/vim-svngutter'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'mustache/vim-mustache-handlebars'
Plug 'chase/vim-ansible-yaml'
Plug 'jamessan/vim-gnupg'

" Add plugins to &runtimepath
call plug#end()
" End vim-plug

" Filetypes
if has("autocmd")
  filetype plugin indent on " automatic per-language indentation
  " filetype detection
  "" see http://beerpla.net/2008/04/02/how-to-add-a-vim-file-extension-to-syntax-highlighting/
  augroup filenames
    autocmd BufRead,BufNewFile *.go setlocal filetype=go
    autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
  augroup end
  " specific filetype overrides
  augroup filetypes
    " reset if ft changes
    "autocmd FileType *              setlocal noexpandtab   tabstop=3 shiftwidth=3
    " filetypes
"    autocmd FileType asm            setlocal noexpandtab tabstop=8 shiftwidth=8
"    autocmd FileType gitcommit      setlocal                                                                  spell
"    autocmd FileType html,xhtml,xml setlocal             tabstop=2 shiftwidth=2
"    autocmd FileType make           setlocal noexpandtab
"    autocmd FileType markdown       setlocal                                    colorcolumn=101 textwidth=100
"    autocmd FileType st             setlocal noexpandtab
"    autocmd FileType sql,plsql      setlocal             tabstop=2 shiftwidth=2
"    autocmd FileType sudoers        setlocal noexpandtab
"    autocmd FileType tex,plaintex   setlocal noexpandtab tabstop=2 shiftwidth=2 colorcolumn=101 textwidth=100 spell inde=
"    autocmd FileType verilog        setlocal noexpandtab
"    autocmd FileType vim            setlocal             tabstop=2 shiftwidth=2
  augroup end
  " custom types
  augroup custom
    autocmd BufRead,BufNewFile *.notes setlocal filetype=markdown shiftwidth=2 colorcolumn=101 textwidth=100
  augroup end
endif

" highlighting for some of our configs
au BufReadPost ~/svn/sysadmin/ssh_config_template/conf.d/* setlocal filetype=sshconfig
au BufReadPost ~/.ssh/conf.d/* setlocal filetype=sshconfig
" Nginx Configs
au BufReadPost ~/svn/openresty-config/** setlocal filetype=nginx 

" Don't let the puppet plugin do auto alignment
let g:puppet_align_hashes = 0

" override iskeyword from the puppet bundle to allow "regular" word movement
" TODO noautoindent isn't enough to stop stupid indenting with comments, need
" to look into smartindent and the puppet module
au BufReadPost *.pp setlocal iskeyword+=^:,^- noautoindent nosmartindent
