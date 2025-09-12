-- ~/.config/nvim/init.lua
-- ============================================================================
-- NEOVIM CONFIGURATION - SETUP COMPLETO
-- ============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- CONFIGURAÇÕES BÁSICAS
-- ============================================================================

-- Cursor format
vim.o.guicursor = 'a:hor25,i:ver25'

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line breaking
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakident = true

-- Configurações gerais
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = "menuone,noselect"
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.showtabline = 4
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- ============================================================================
-- PLUGINS
-- ============================================================================

require("lazy").setup({
    -- ========================================================================
    -- COLORSCHEME
    -- ========================================================================
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "deep", -- escolhe o estilo que curtir: dark, darker, cool, deep, warm, warmer
                transparent = true,
                term_colors = true,
                code_style = {
                    comments = "italic",
                    keywords = "italic",
                    functions = "italic",
                    strings = "none",
                    variables = "none",
                },
            })
            require("onedark").load()
        end,
    },

    -- ========================================================================
    -- LSP & AUTOCOMPLETION
    -- ========================================================================
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "folke/neodev.nvim",
        },
    },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Web Development
                    "ts_ls",       -- TypeScript/JavaScript
                    "html",        -- HTML
                    "cssls",       -- CSS
                    "tailwindcss", -- Tailwind CSS
                    "emmet_ls",    -- Emmet

                    -- Backend
                    "pyright",       -- Python
                    "gopls",         -- Go
                    "rust_analyzer", -- Rust
                    "clangd",        -- C/C++

                    -- Scripting & Config
                    "lua_ls",   -- Lua
                    "bashls",   -- Bash
                    "yamlls",   -- YAML
                    "jsonls",   -- JSON
                    "dockerls", -- Docker

                    -- Other
                    "marksman", -- Markdown
                },
                automatic_installation = true,
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
    },

    -- LSP kind icons
    {
        "onsails/lspkind.nvim",
    },

    -- Neodev for Lua development
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()
        end,
    },

    -- ========================================================================
    -- SYNTAX HIGHLIGHTING
    -- ========================================================================
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua", "javascript", "typescript", "python", "go",
                    "rust", "c", "cpp", "java", "html", "css", "json",
                    "yaml", "toml", "bash", "dockerfile", "sql", "markdown",
                    "vim", "vimdoc", "query"
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            })
        end
    },

    -- ========================================================================
    -- ERROR LENS & DIAGNOSTICS
    -- ========================================================================
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({
                position = "bottom",
                height = 10,
                width = 50,
                icons = true,
                mode = "workspace_diagnostics",
                fold_open = "",
                fold_closed = "",
                group = true,
                padding = true,
                cycle_results = true,
                action_keys = {
                    close = "q",
                    cancel = "<esc>",
                    refresh = "r",
                    jump = { "<cr>", "<tab>" },
                    open_split = { "<c-x>" },
                    open_vsplit = { "<c-v>" },
                    open_tab = { "<c-t>" },
                    jump_close = { "o" },
                    toggle_mode = "m",
                    toggle_preview = "P",
                    hover = "K",
                    preview = "p",
                    close_folds = { "zM", "zm" },
                    open_folds = { "zR", "zr" },
                    toggle_fold = { "zA", "za" },
                    previous = "k",
                    next = "j"
                },
                signs = {
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "﫠"
                },
                use_diagnostic_signs = false
            })
        end
    },

    -- ========================================================================
    -- UI ENHANCEMENTS
    -- ========================================================================
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "onedark",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", {
                        "diagnostics",
                        sources = { "nvim_diagnostic", "nvim_lsp" },
                        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                        diagnostics_color = {
                            color_error = { fg = "#ff9e64" },
                            color_warn = { fg = "#e0af68" },
                            color_info = { fg = "#0db9d7" },
                            color_hint = { fg = "#1abc9c" },
                        },
                    } },
                    lualine_c = {
                        {
                            "filename",
                            file_status = true,
                            newfile_status = false,
                            path = 1,
                            shorting_target = 40,
                            symbols = {
                                modified = '[+]',
                                readonly = '[RO]',
                                unnamed = '[No Name]',
                                newfile = '[New]',
                            }
                        }
                    },
                    lualine_x = {
                        {
                            "encoding",
                            cond = function()
                                return vim.opt.encoding:get() ~= "utf-8"
                            end
                        },
                        "fileformat",
                        "filetype"
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "│",
                    tab_char = "│",
                },
                scope = { enabled = false },
                exclude = {
                    filetypes = {
                        "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy",
                        "mason", "notify", "toggleterm", "lazyterm"
                    },
                },
            })
        end
    },

    -- ========================================================================
    -- FILE EXPLORER & TELESCOPE
    -- ========================================================================
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-n>"] = require("telescope.actions").cycle_history_next,
                            ["<C-p>"] = require("telescope.actions").cycle_history_prev,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        },
                    },
                },
            })
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                    side = 'right',
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })
        end,
    },

    -- ========================================================================
    -- GIT INTEGRATION
    -- ========================================================================
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs                        = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn                   = true,
                numhl                        = false,
                linehl                       = false,
                word_diff                    = false,
                watch_gitdir                 = {
                    follow_files = true
                },
                attach_to_untracked          = true,
                current_line_blame           = false,
                current_line_blame_opts      = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority                = 6,
                update_debounce              = 100,
                status_formatter             = nil,
                max_file_length              = 40000,
                preview_config               = {
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
            })
        end
    },

    -- ========================================================================
    -- UTILITY PLUGINS
    -- ========================================================================
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            require("which-key").setup()
        end
    },

    -- Web devicons
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end
    },
})

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================

-- Configuração de diagnósticos (Error Lens style)
vim.diagnostic.config({
    virtual_text = {
        enabled = true,
        source = "if_many",
        prefix = "●",
        format = function(diagnostic)
            local code = diagnostic.code or
                (diagnostic.user_data and diagnostic.user_data.lsp and diagnostic.user_data.lsp.code)
            if code then
                return string.format("%s [%s]", diagnostic.message, code)
            end
            return diagnostic.message
        end,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        format = function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
        end,
    },
})

-- Símbolos de diagnóstico
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configuração do LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    print("🚀 LSP conectado: " .. client.name)
    local opts = { buffer = bufnr, remap = false }

    -- Keymaps LSP
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
    end, opts)
end

-- Setup automático dos LSPs
require("mason-lspconfig").setup({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,

    -- Configurações específicas
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,

    ["ts_ls"] = function()
        require("lspconfig").ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
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
        })
    end,
})

-- ============================================================================
-- AUTOCOMPLETION SETUP
-- ============================================================================

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end
        }),
    },
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

local opts = { noremap = true, silent = true }

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "p", '"_dP', opts)

-- Visual Block
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- File explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Better paste
vim.keymap.set("v", "p", '"_dP', opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

print("✅ Configuração do Neovim carregada com sucesso!")
