local servers = {
    clangd = {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = { "compile_commands.json", ".clangd", ".git" },
    },
    ["rust-analyzer"] = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "rust-project.json", ".git" },
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                check = { command = "clippy" },
            },
        },
    },
    zls = {
        cmd = { "zls" },
        filetypes = { "zig", "zir" },
        root_markers = { "build.zig", "zls.json", ".git" },
    },
    ["typescript-language-server"] = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
        },
        root_markers = {
            "package.json",
            "tsconfig.json",
            "jsconfig.json",
            "pnpm-workspace.yaml",
            ".git",
        },
        settings = {
            diagnostics = { enable = true },
            completions = { completeFunctionCalls = true },
            tsserver = {
                logVerbosity = "warning",
                maxTsServerMemory = 4096,
            },
        },
        init_options = {
            hostInfo = "neovim",
            preferences = {
                includeAutomaticOptionalChainCompletions = true,
                includeCompletionsForImportStatements = true,
                includeCompletionsForModuleExports = true,
                includeCompletionsWithSnippetText = true,
                includeCompletionsWithInsertText = true,
                allowRenameOfImportPath = true,
                providePrefixAndSuffixTextForRename = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
    basedpyright = {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
            "pyproject.toml",
            "setup.cfg",
            "setup.py",
            "requirements.txt",
            "Pipfile",
            ".git",
        },
        settings = {
            basedpyright = {
                disableOrganizeImports = true,
                analysis = {
                    autoImportCompletions = true,
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    typeCheckingMode = "standard",
                },
            },
        },
    },
    ruff_lsp = {
        cmd = { "ruff-lsp" },
        filetypes = { "python" },
        root_markers = {
            "pyproject.toml",
            "ruff.toml",
            "ruff.ini",
            "setup.cfg",
            ".git",
        },
        settings = {
            ruff_lsp = {
                unsafeFixes = true,
            },
        },
    },
}

return servers
