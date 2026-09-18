return {
  -- Git blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPost",
    opts = {
      enabled = false,
      message_template = " <date> • <author> • <summary>",
      date_format = "%Y-%m-%d",
      virtual_text_column = 1,
      max_commit_msg_length = 80,
    },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
    },
  },
}
