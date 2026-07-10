return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local opts = { buffer = bufnr }

      -- Hunk navigation (falls back to normal ]c/[c in diff mode)
      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, vim.tbl_extend("force", opts, { desc = "Next git hunk" }))

      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, vim.tbl_extend("force", opts, { desc = "Previous git hunk" }))

      vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk,
        vim.tbl_extend("force", opts, { desc = "Stage hunk (again to unstage)" }))

      vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk,
        vim.tbl_extend("force", opts, { desc = "Reset hunk" }))

      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk,
        vim.tbl_extend("force", opts, { desc = "Preview hunk" }))

      vim.keymap.set("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, vim.tbl_extend("force", opts, { desc = "Blame line" }))
    end,
  },
}
