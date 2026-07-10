return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").setup()

    local parsers = {
      "lua",
      "vim",
      "vimdoc",
      "query",

      "python",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",

      "go",
      "gomod",
      "gosum",
      "gowork",

      "bash",
      "dockerfile",
      "terraform",
      "hcl",
      "sql",
      "markdown",
      "markdown_inline",
    }

    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)

        -- Treesitter indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
