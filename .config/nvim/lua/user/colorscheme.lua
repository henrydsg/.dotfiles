vim.cmd([[
  try
    colorscheme evening
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
  endtry
  ]]
)
