local M = {}

function M.git_enabled()
	local job = require("plenary.job"):new({
		command = "/bin/sh",
		args = { "-c", "git config --get remote.origin.url | awk -F'[/:]' '{print $4}'" },
	})
	job:sync()
	return os.getenv("GITLAB_HOST") == job:result()[1]
end

function M.glab_coworkers_mr()
	return "glab mr list "
		.. "--not-draft "
		.. '--not-label "Parking,Threads" '
		.. "--output json | "
		.. "jq -r "
		.. "'(.[] | "
		.. "select(.labels | length != 0) | "
		.. "["
		.. '"\\u001b[32m" + .author.name + "\\u001b[0m", '
		.. '((.title | sub("feat:"; ""))[:35] + (if (.title | sub("feat:"; "")) | length > 35 then "..." else "" end))'
		.. "]) | "
		.. "@tsv' | "
		.. "column -t -s $'\t'"
end

return M
