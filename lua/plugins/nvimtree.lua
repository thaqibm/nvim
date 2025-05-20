
local config = function()
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local file_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        ignored = "◌",
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
}

nvim_tree = require("nvim-tree")

local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
    vim.keymap.set('n', 'O', '', { buffer = bufnr })
    vim.keymap.del('n', 'O', { buffer = bufnr })
    vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
    vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
    vim.keymap.set('n', 'D', '', { buffer = bufnr })
    vim.keymap.del('n', 'D', { buffer = bufnr })
    vim.keymap.set('n', 'E', '', { buffer = bufnr })
    vim.keymap.del('n', 'E', { buffer = bufnr })

    vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', 'P', function()
        local node = api.tree.get_node_under_cursor()
        print(node.absolute_path)
    end, opts('Print Node Path'))

    vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
end


nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 30,
        side = "left",
        number = false,
        relativenumber = false,
    },
    renderer = {
        icons = {
            glyphs = file_icons
        }
    },
    on_attach = my_on_attach
}

end

return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = config
	}
}
