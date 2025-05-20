
local config = function()
    local status_ok, mason = pcall(require, "mason")
    if not status_ok then
        return
    end
    local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not status_ok then
        return
    end

    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
        return
    end


    local M = require("plugins.lsp.handler")
    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    })
    mason_lspconfig.setup{}

    mason_lspconfig.setup_handlers {
        function(server)
            local opts = {
                on_attach = M.on_attach,
                capabilities = M.capabilities,
            }
            lspconfig[server].setup(opts)
        end
    }

    M.setup()
end

return {
    -- lspconfig
    {
        { "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "mason.nvim",
            { "mason-org/mason-lspconfig.nvim", config = function() end },
            { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },
        },
        keys = {
                { "gd", vim.lsp.buf.definition, buffer = true, desc = "Goto [D]efinition"  },
                { "gl", vim.diagnostic.open_float, {buffer = true, desc = "Goto [D]efinition", noremap = true, silent = true } },
                { "gr", vim.lsp.buf.references, {buffer = true, desc = "[R]eferences", noremap = true, silent = true } },
                { "gI", vim.lsp.buf.implementation, {buffer = true, desc = "Goto [I]mplementation" , noremap = true, silent = true } },
                { "gy", vim.lsp.buf.type_definition, {buffer = true, desc = "Goto T[y]pe Definition" , noremap = true, silent = true } },
                { "gD", vim.lsp.buf.declaration, {desc = "Goto [D]eclaration" , noremap = true, silent = true } },
                { "K", function() return vim.lsp.buf.hover {border = "rounded"} end, {buffer = true, desc = "Hover" , noremap = true, silent = true } },
                { "gK", function() return vim.lsp.buf.signature_help {border = "rounded"} end, {buffer = true, desc = "Signature Help"} },
                { "<c-k>", function() return vim.lsp.buf.signature_help() end, {buffer = true, desc = "Signature Help", noremap = true, silent = true }, mode = {"n", "i"} },
                { "<leader>ca", vim.lsp.buf.code_action, {buffer = true, desc = "Code Action", noremap = true, silent = true } },
                { "<leader>cc", vim.lsp.codelens.run, {desc = "Run Codelens", noremap = true, silent = true } },
                { "<leader>cC", vim.lsp.codelens.refresh, {desc = "Refresh & Display Codelens", noremap = true, silent = true } },
                { "<leader>cr", vim.lsp.buf.rename, {buffer = true, desc = "Rename", noremap = true, silent = true } },
            },
            config = config
        },
        { "mason-org/mason.nvim", version = "^1.0.0" },
        { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    }

}

