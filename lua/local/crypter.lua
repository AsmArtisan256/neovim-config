local api = vim.api
local fn = vim.fn

local function run_openssl(args, input, password)
	return vim.system(args, {
		stdin = input,
		env = { NVIM_CRYPT_PASS = password },
	}):wait()
end

local function split_output(out)
	local cleaned = out:gsub("\r\n", "\n"):gsub("\n$", "")
	return vim.split(cleaned, "\n", { plain = true })
end

local function encrypt()
	local line_start = fn.getpos("'<")[2]
	local line_end = fn.getpos("'>")[2]
	local lines = fn.getline(line_start, line_end)
	local text = table.concat(lines, "\n") .. "\n"

	local password = fn.inputsecret("Password: ")
	if password == "" then
		return
	end
	local password2 = fn.inputsecret("Verify password: ")
	if password ~= password2 then
		vim.notify("Passwords do not match", vim.log.levels.WARN)
		return
	end

	local res = run_openssl(
		{ "openssl", "enc", "-aes-256-cbc", "-pbkdf2", "-a", "-pass", "env:NVIM_CRYPT_PASS" },
		text,
		password
	)
	if res.code ~= 0 then
		vim.notify("Encryption failed: " .. vim.trim(res.stderr or ""), vim.log.levels.ERROR)
		return
	end

	api.nvim_buf_set_lines(0, line_start - 1, line_end, false, split_output(res.stdout))
end

local function decrypt()
	local line_start = fn.getpos("'<")[2]
	local line_end = fn.getpos("'>")[2]
	local lines = fn.getline(line_start, line_end)
	local text = table.concat(lines, "\n") .. "\n"

	local password = fn.inputsecret("Password: ")
	if password == "" then
		return
	end

	local res = run_openssl(
		{ "openssl", "enc", "-aes-256-cbc", "-pbkdf2", "-a", "-d", "-pass", "env:NVIM_CRYPT_PASS" },
		text,
		password
	)
	-- Fallback for blocks encrypted before -pbkdf2 migration
	if res.code ~= 0 then
		res = run_openssl(
			{ "openssl", "enc", "-aes-256-cbc", "-a", "-d", "-pass", "env:NVIM_CRYPT_PASS" },
			text,
			password
		)
	end
	if res.code ~= 0 then
		vim.notify("Decryption failed (wrong password or invalid ciphertext)", vim.log.levels.ERROR)
		return
	end

	api.nvim_buf_set_lines(0, line_start - 1, line_end, false, split_output(res.stdout))
end

api.nvim_create_user_command("VisualEncrypt", encrypt, { range = true })
api.nvim_create_user_command("VisualDecrypt", decrypt, { range = true })
