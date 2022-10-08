require "userv1.options"
require "userv1.keymap"
require "userv1.plugin"
require "userv1.colorscheme"
require "userv1.cmp"
require "userv1.lsp"
require "userv1.treesitter"
require "userv1.nvim-tree"
require "userv1.bufferline"
require "userv1.toggleterm"

-- Disabled plugins:
-- require "userv1.lualine"
-- require "userv1.impatient"

local o = vim.opt
local g = vim.g

o.guifont = 'Hack Nerd Font:h16'
