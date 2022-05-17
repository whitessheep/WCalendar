-- [[ --- 通用模块 --- ]]
local type = type
local utils = require("app.libs.utils")
local user_model = require("app.model.user")
local common_router = {}

local function topics_category_handler(current_category, req, res, next)
	---------------------------------------
	if not req.session.get("user") then
		return res:render("login")
	end
	local current_userid = req.session.get("user").userid;

    -- local username = req.params.username
	-- if not username or username == "" then
	-- 	return res:render("error", {
    --         errMsg = "参数错误111."
    --     })
	-- end

    -- 查看的用户
	local result, err = user_model:query_by_id(current_userid)
	if not result or err then
		return res:render("error", {
            errMsg = "无法查找到用户."
        })
	end

	local user = result
	-------------------------------------------------
    res:render("index", {
    	diff_days = diff_days,
    	diff = diff,
		user = user,
        user_count = user_count,
        topic_count = topic_count,
        comment_count = comment_count,
        current_category = current_category
    })
end

common_router.settings = function(req, res, next)
	local user_id = req.session.get("user").userid
	if not user_id or user_id == 0 then
		return res:render("error", {
			errMsg = "cannot find user, please login."
		})
	end

	local result, err = user_model:query_by_id(user_id)
	if not result or err then
		return res:render("error", {
			errMsg = "error to find user."
		})
	end

    res:render("user/settings", {
        user = result
    })
end

common_router.index = function(req, res, next)
	local current_category = 0
    topics_category_handler(current_category, req, res, next)
end

common_router.calendar = function(req, res, next)
	local user_id = req.session.get("user").userid
	if not user_id or user_id == 0 then
		return res:render("error", {
			errMsg = "cannot find user, please login."
		})
	end

	local result, err = user_model:query_by_id(user_id)

    res:render("schoolCalendar", {
        user = result
    })
end

common_router.try = function(req, res, next)
	-- local user_id = req.session.get("user").userid
	-- if not user_id or user_id == 0 then
	-- 	return res:render("error", {
	-- 		errMsg = "cannot find user, please login."
	-- 	})
	-- end

	-- local result, err = user_model:query_by_id(user_id)

    res:render("try")
end

return common_router