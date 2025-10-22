local handler = require("plugins.lsp.handler")

local configured = false

local function get_servers()
    local user_servers = vim.g.lsp_servers
    if type(user_servers) ~= "table" then
        return {}
    end

    if vim.tbl_islist(user_servers) then
        local servers = {}
        for _, name in ipairs(user_servers) do
            servers[name] = {}
        end
        return servers
    end

    return vim.deepcopy(user_servers)
end

local function setup_servers()
    if configured then
        return
    end
    configured = true

    handler.setup()

    vim.lsp.config("*", {
        capabilities = handler.capabilities,
        on_attach = handler.on_attach,
    })

    local servers = get_servers()
    local enabled = {}

    if vim.tbl_isempty(servers) then
        vim.notify("[lsp] No LSP servers configured (vim.g.lsp_servers).", vim.log.levels.INFO)
        return
    end

    for name, server_opts in pairs(servers) do
        vim.lsp.config(name, server_opts)
        local resolved = vim.lsp.config[name]
        local cmd = resolved and resolved.cmd

        local should_enable = true
        if type(cmd) == "table" and cmd[1] ~= nil then
            if vim.fn.executable(cmd[1]) == 0 then
                should_enable = false
                vim.notify(
                    string.format("[lsp] Skipping %s, command %q not found.", name, cmd[1]),
                    vim.log.levels.WARN
                )
            end
        end

        if should_enable then
            table.insert(enabled, name)
        end
    end

    if #enabled > 0 then
        vim.lsp.enable(enabled)
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = setup_servers,
    },
}
