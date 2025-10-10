local M = {}

M.GITLAB_HOST = os.getenv("GITLAB_HOST") or "https://gitlab.com"
M.GITLAB_MR_URL = M.GITLAB_HOST .. (os.getenv("GITLAB_MR_URL") or "/merge_requests")
M.USER = os.getenv("USER") or "unknown"

local function build_url(base, params)
	local query = {}
	for k, v in pairs(params) do
		table.insert(query, ("%s=%s"):format(k, v))
	end
	return base .. "?" .. table.concat(query, "&")
end

function M.my_merge_requests()
	return build_url(M.GITLAB_MR_URL, {
		sort = "created_date",
		state = "opened",
		["author_username"] = M.USER,
		["label_name%5B%5D"] = "Any",
		first_page_size = 20,
	})
end

function M.coworker_merge_requests()
	return build_url(M.GITLAB_MR_URL, {
		sort = "created_date",
		state = "opened",
		["approver%5B%5D"] = "None",
		draft = "no",
		["not%5Bauthor_username%5D%5B%5D"] = M.USER,
		["label_name%5B%5D"] = "Any",
		["not%5Blabel_name%5D%5B%5D"] = "Parking",
		first_page_size = 20,
	})
end

return M
