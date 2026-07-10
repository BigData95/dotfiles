local servers = {
  "lua_ls",
  "pyright",
  "ruff",
  "gopls",
  "ts_ls",
  "eslint",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "dockerls",
  "bashls",
  "terraformls",
}

local default_servers = {
  "pyright",
  "ruff",
  "ts_ls",
  "eslint",
  "html",
  "cssls",
  "dockerls",
  "bashls",
  "terraformls",
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
      "b0o/schemastore.nvim",
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

      -- JSON/YAML validation + completion from schemastore.org
      -- (CloudFormation, GitHub Actions, docker-compose, tsconfig, ...)
      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              -- Disable built-in store; schemastore.nvim provides a
              -- newer catalog and avoids duplicate schema matches.
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
            -- CloudFormation intrinsic function tags
            customTags = {
              "!Ref",
              "!Sub",
              "!Sub sequence",
              "!GetAtt",
              "!GetAZs",
              "!ImportValue",
              "!Base64",
              "!Cidr sequence",
              "!Join sequence",
              "!Select sequence",
              "!Split sequence",
              "!FindInMap sequence",
              "!If sequence",
              "!Equals sequence",
              "!Not sequence",
              "!And sequence",
              "!Or sequence",
              "!Condition",
            },
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

          -- Ruff only lints; let pyright own hover docs
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
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
