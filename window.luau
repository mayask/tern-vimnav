-- vim-tmux-navigator for Tern.
--
-- Bind ctrl+h/j/k/l to `plugin.vimnav.left|down|up|right` in settings.json.
-- In a Vim pane the key is passed through, so Vim moves between its own splits;
-- anywhere else Tern moves focus in that direction.
-- At its edge Vim asks Tern to move on by setting its title to `tern-nav:<dir>`.

local VIM = { nvim = true, vim = true }

-- Control bytes for ctrl+h/j/k/l as the terminal would send them.
local KEY = { left = "\8", down = "\10", up = "\11", right = "\12" }

local function is_vim(pane)
	local program = pane and pane.program
	return program ~= nil and VIM[program:match("[^/]+$")] == true
end

for dir, byte in KEY do
	tern.command({
		id = dir,
		title = "Navigate " .. dir .. " (Vim-aware)",
		run = function(cx)
			local pane = cx.session:pane("@focused")
			if is_vim(pane) then
				cx:run(pane.pane, byte)
			else
				cx:action("focus_pane:" .. dir)
			end
		end,
	})
end

tern.on("title", function(ev, cx)
	local dir = ev.title:match("^tern%-nav:(%a+)$")
	if dir and KEY[dir] and ev.pane == cx.session:focused() then
		cx:action("focus_pane:" .. dir)
	end
end)
