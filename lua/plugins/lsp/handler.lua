local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    local config = {
        virtual_text = {
            spacing = 4,
            prefix = "●",
            severity = vim.diagnostic.severity.ERROR,
        },
        -- show signs
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

M.on_attach = function(_, bufnr)
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gr", vim.lsp.buf.references, "Goto References")
    map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")
    map("n", "gl", function()
        vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
    end, "Line Diagnostics")
    map("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
    end, "Hover Documentation")
    map("n", "gK", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
    end, "Signature Help")
    map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
    map("n", "<leader>cc", vim.lsp.codelens.run, "Run CodeLens")
    map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh CodeLens")

    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
else
    M.capabilities = capabilities
end

return M
