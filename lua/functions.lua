function Tdump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. Tdump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

-- show docs on things with <S-k>
function Show_documentation()
	if vim.tbl_contains({ "vim", "help" }, vim.bo.filetype) then
		vim.cmd.help(vim.fn.expand("<cword>"))
	else
		vim.lsp.buf.hover()
	end
end

-- scratch function
function CreateScratchBuffer(vertical)
	vim.cmd(vertical and "vnew" or "new")
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "hide"
	vim.bo.swapfile = false
	vim.bo.filetype = "scratch"
end

-- function to insert time stamp
function InsertDateStamp()
	vim.api.nvim_put({ os.date("%Y-%m-%d") }, "c", true, true)
end
