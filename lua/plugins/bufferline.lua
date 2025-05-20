local config = function ()
    local bufferline = require("bufferline")
    vim.opt.termguicolors = true
    bufferline.setup{
        highlights = {
            buffer_selected = {
                bold = true,
                italic = false,
            },
        },
        options = {
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
            close_icon = '',
            buffer_close_icon = '',
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
        },
    }
end

return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        lazy = false,
        keys = {
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = config
    }
}
