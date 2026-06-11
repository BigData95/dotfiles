local servers = {
  "lua_ls",
  "pyright",
  "gopls",
  "ts_ls",
  "eslint",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "dockerls",
  "bashls",
}

local default_servers = {
  "pyright",
  "ts_ls",
  "eslint",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "dockerls",
  "bashls",
}

local format_on_save_servers = {
  gopls = true,
  lua_ls = true,
}

return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = servers,

      -- We enable servers ourselves after applying capabilities.
      automatic_enable = false,
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
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
          },
        },
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      for _, server in ipairs(default_servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      vim.lsp.enable(servers)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("ilich-lsp-attach", { clear = true }),

        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local opts = { buffer = event.buf }

          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end

          if client
            and format_on_save_servers[client.name]
            and client:supports_method("textDocument/formatting")
          then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = event.buf,
                  id = client.id,
                  timeout_ms = 1000,
                })
              end,
            })
          end

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
            desc = "Go to definition",
          }))

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, {
            desc = "Go to declaration",
          }))

          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, {
            desc = "Go to implementation",
          }))

          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, {
            desc = "Go to references",
          }))

          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
            desc = "Hover documentation",
          }))

          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, {
            desc = "Rename symbol",
          }))

          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
            desc = "Code action",
          }))

          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({
              async = true,
              bufnr = event.buf,
            })
          end, vim.tbl_extend("force", opts, {
            desc = "Format file",
          }))

          vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({
              count = -1,
              float = true,
            })
          end, vim.tbl_extend("force", opts, {
            desc = "Previous diagnostic",
          }))

          vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({
              count = 1,
              float = true,
            })
          end, vim.tbl_extend("force", opts, {
            desc = "Next diagnostic",
          }))

          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, {
            desc = "Show diagnostic",
          }))
        end,
      })
    end,
  },
}
