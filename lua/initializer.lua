local function safe_require(mod)
  local config = vim.fn.stdpath("config")
  local path = config .. "/lua/" .. mod:gsub("%.", "/")

  local file = path .. ".lua"
  local init_file = path .. "/init.lua"

  if vim.uv.fs_stat(file) or vim.uv.fs_stat(init_file) then
    return require(mod)
  end

  return nil
end

require("general")
require("general.setcellwidths")

require("theme")

require("functions")
require("mappings")
require("commands")

-- local

safe_require("local.crypter")
safe_require("local.secrets")

-- plugins

require("plugins.general")

require("plugins.treesitter")

require("plugins.autotag")
require("plugins.lualine")
require("plugins.ultimate-autopair")
require("plugins.highlightedyank")

require("plugins.surround")

require("plugins.diffview")
require("plugins.gitmessenger")
require("plugins.gitsigns")

require("plugins.cmp")
require("plugins.lsp")
require("plugins.formatter")

require("plugins.whichkey")

require("plugins.multiplecursors")
require("plugins.fzf")
require("plugins.flash")
require("plugins.nvim_comment")
require("plugins.vimtex")
require("plugins.sessions")
require("plugins.indent")
require("plugins.windowpicker")
require("plugins.guessindent")
require("plugins.todocomments")
require("plugins.bufdel")
require("plugins.compile-mode")
