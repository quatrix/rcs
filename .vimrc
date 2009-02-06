syntax on
set tabstop=4
set shiftwidth=4
set expandtab
colorscheme asmdev

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  execute "normal! O"
  execute "normal! se im"
  execute "normal! imap <Esc> <C-L>"
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

map <F2>  mz :%!perltidy -q<CR>`z :w<CR>
map <S-y> y$ <cr>
map ,t <ESC>:tabnew <cr>
map <C-t> <ESC>:tabnew<cr>
map <C-h> <ESC>:tabprev <cr>
map <C-l> <ESC>:tabnext <cr>
map <C-w> <ESC>:tabclose <cr>
map <C-a> <ESC>:tabclose <cr>

imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l
imap <C-a> <C-o>^
imap <C-e> <C-o>$

let mapleader="`"
