local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = {'c', 'rust', 'cpp', 'python', 'scala', 'lua'},
  sync_install = false, 
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true},
}
