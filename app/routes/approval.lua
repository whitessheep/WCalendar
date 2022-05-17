-- [[ --- 审批模块 --- ]]
local pairs = pairs
local ipairs = ipairs
local smatch = string.match
local slen = string.len
local utils = require("app.libs.utils")
local pwd_secret = require("app.config.config").pwd_secret
local lor = require("lor.index")
local user_model = require("app.model.user")
local notification_model = require("app.model.notification")
local course_model = require("app.model.course")
local schedule_model = require("app.model.schedule")
local lessonplan_model = require("app.model.lessonplan")
local approval_router = lor:Router()

approval_router:get("/view", function(req, res, next)
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

    res:render("approval/view", {
        user = result
    })
end)


approval_router:get("/:lessonplan/allow", function(req, res, next)
    local userid = req.session.get('user').userid
    local lessonplan_id = req.params.lessonplan
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end


    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",semester, " total_period ",coursename, " theoretical_period ",teachername, " experimental_period ",classname)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local success = lessonplan_model:setState(2, lessonplan_id)

    if success then
        res:json({
            success = true,
            msg = "编辑成功."
        })
    else
        res:json({
            success = false,
            msg = "编辑失败."
        })
    end
end)

approval_router:get("/:lessonplan/refuse", function(req, res, next)
    local userid = req.session.get('user').userid
    local lessonplan_id = req.params.lessonplan
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end


    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",semester, " total_period ",coursename, " theoretical_period ",teachername, " experimental_period ",classname)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local success = lessonplan_model:setState(0, lessonplan_id)

    if success then
        res:json({
            success = true,
            msg = "编辑成功."
        })
    else
        res:json({
            success = false,
            msg = "编辑失败."
        })
    end
end)

approval_router:get("/:lessonplan/submit", function(req, res, next)
    local userid = req.session.get('user').userid
    local lessonplan_id = req.params.lessonplan
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end


    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",semester, " total_period ",coursename, " theoretical_period ",teachername, " experimental_period ",classname)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local success = lessonplan_model:setState(1, lessonplan_id)

    if success then
        res:json({
            success = true,
            msg = "编辑成功."
        })
    else
        res:json({
            success = false,
            msg = "编辑失败."
        })
    end
end)
return approval_router
