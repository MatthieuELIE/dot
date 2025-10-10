local M = {}

-- Safely run shell commands
local function exec(cmd)
	local handle = io.popen(cmd)
	if not handle then
		return nil
	end
	local result = handle:read("*a")
	handle:close()
	return result and result:gsub("%s+$", "") or nil
end

-- Build URL with query parameters
local function build_url(base, params)
	local query = {}
	for k, v in pairs(params) do
		table.insert(query, ("%s=%s"):format(k, v))
	end
	return base .. "?" .. table.concat(query, "&")
end

-- Detect GitLab URL and username
local GITLAB_URL = os.getenv("GITLAB_URL") or "https://gitlab.example.com/merge_requests"
local USER = exec("git config user.name") or os.getenv("USER") or "unknown"

function M.my_merge_requests()
	return build_url(GITLAB_URL, {
		sort = "created_date",
		state = "opened",
		["author_username"] = USER,
		["label_name%5B%5D"] = "Any",
		first_page_size = 20,
	})
end

function M.coworker_merge_requests()
	return build_url(GITLAB_URL, {
		sort = "created_date",
		state = "opened",
		["approver%5B%5D"] = "None",
		draft = "no",
		["not%5Bauthor_username%5D%5B%5D"] = USER,
		["label_name%5B%5D"] = "Any",
		["not%5Blabel_name%5D%5B%5D"] = "Parking",
		first_page_size = 20,
	})
end

return M
