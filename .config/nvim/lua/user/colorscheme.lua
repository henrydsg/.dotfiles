vim.cmd([[
  try
    colorscheme desert
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
  endtry
  ]]
)
