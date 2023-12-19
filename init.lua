local modules = {
    "userv1.options",
    "userv1.keymap",
    "userv1.plugin",
    "userv1.colorscheme",
    "userv1.cmp",
    "userv1.lsp",
    "userv1.treesitter",
    "userv1.nvimtree",
    "userv1.bufferline",
    "userv1.toggleterm",
    "userv1.knap",
    "userv1.telescope",
    "userv1.lualine",
}

-- Function to log errors in Neovim
local function log_error(err)
    vim.api.nvim_err_writeln("Error loading module: " .. err)
end

-- Load modules using pcall and log errors
for _, module in ipairs(modules) do
    local success, err = pcall(require, module)
    if not success then
        log_error(err)
    end
end


local o = vim.opt
local g = vim.g


g.loaded_netrw       = 1
g.loaded_netrwPlugin = 1

o.guifont = 'Hack Nerd Font:h16'
