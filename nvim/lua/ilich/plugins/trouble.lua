return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {},

  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Project diagnostics (Trouble)",
    },
    {
      "<leader>xb",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer diagnostics (Trouble)",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix list (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle<cr>",
      desc = "Document symbols (Trouble)",
    },
  },
}
