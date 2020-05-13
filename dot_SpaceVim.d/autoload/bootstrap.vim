function! bootstrap#before() abort
  " Enable 24-bit RGB color for proper colors.
  "
  "   https://neovim.io/doc/user/options.html#'termguicolors'
  "
  set termguicolors

  "
  " Show search and replacement previews incrementally.
  "
  set inccommand=nosplit

  "
  " Use the left and right keys to switch buffers.
  "
  nnoremap <left>  :bp<CR>
  nnoremap <right> :bn<CR>

endfunction

function! bootstrap#after() abort
  "
  " Use the space key as the vim leader and remap SpaceVim's [SPC] command to
  " be invoked only after the leader is pressed.
  "
  call s:UseSpaceLeader()

  "
  " Modify the base16 theme to have brighter comments.
  "
  call Base16hi('Comment', g:base16_gui09, '', g:base16_cterm09, '', '', '')

  " TODO: Figure out how CoC keybindings should be configured in SpaceVim.
  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  "
  " Register language servers with coc.nvim.
  "
  let g:coc_global_extensions = [
      \'coc-java',
      \'coc-json',
      \'coc-pyright',
      \'coc-rust-analyzer',
      \'coc-tsserver',
  \]
endfunction

function! s:UseSpaceLeader() abort
  "
  " Set the leader to a more easily accessible key.
  "
  " To read about what a leader key is, see:
  "
  "   https://stackoverflow.com/q/1764263
  "
  " This must run in bootstrap#after() because SpaceVim will skip setting up
  " its mappings for the [SPC] command if it detects the leader was already
  " set to <Space>, and we want to keep those mappings.
  "
  let g:mapleader = "\<Space>"

  "
  " Until SpaceVim adds the option to set up a custom [SPC] mapping, we need
  " to do this remapping manually, from <Space> to <Leader><Space>.
  "
  " We can update this if the following is merged:
  "
  "   https://github.com/SpaceVim/SpaceVim/issues/2504
  "
  nunmap <Space>
  vunmap <Space>
  nmap <Leader><Space> [SPC]
  vmap <Leader><Space> [SPC]
endfunction
