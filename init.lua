require "userv1.options"
require "userv1.keymap"
require "userv1.plugin"
require "userv1.colorscheme"
require "userv1.cmp"
require "userv1.lsp"
require "userv1.treesitter"
require "userv1.nvimtree"
require "userv1.bufferline"
require "userv1.toggleterm"
require "userv1.knap"
require "userv1.telescope"
require "userv1.lualine"

-- Disabled plugins:
-- require "userv1.impatient"

local o = vim.opt
local g = vim.g


g.loaded_netrw       = 1
g.loaded_netrwPlugin = 1

o.guifont = 'Hack Nerd Font:h16'
