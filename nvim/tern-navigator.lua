-- Seamless ctrl+h/j/k/l between Neovim splits and Tern panes.
-- Pairs with the Tern plugin `vimnav`: at a Neovim edge, setting the title to
-- `tern-nav:<direction>` asks Tern to move focus to the neighbouring pane.

local in_tern = vim.env.TERM_PROGRAM == "tern"

local function tern_move(direction)
  local title, titlestring = vim.o.title, vim.o.titlestring
  vim.o.title = true
  vim.o.titlestring = "tern-nav:" .. direction
  vim.cmd.redraw()
  vim.o.titlestring = titlestring
  vim.o.title = title
  vim.cmd.redraw()
end

---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  opts = {
    at_edge = function(ctx)
      if in_tern then
        tern_move(ctx.direction)
      else
        ctx.wrap()
      end
    end,
  },
}
