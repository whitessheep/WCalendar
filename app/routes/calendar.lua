-- [[ --- 用户模块 --- ]]
local pairs = pairs
local ipairs = ipairs
local smatch = string.match
local slen = string.len
local utils = require("app.libs.utils")
local time = require("app.libs.time")
local pwd_secret = require("app.config.config").pwd_secret
local lor = require("lor.index")
local user_model = require("app.model.user")
local notification_model = require("app.model.notification")
local course_model = require("app.model.course")
local lessonplan_model = require("app.model.lessonplan")
local calendar_model = require("app.model.calendar")
local calendar_router = lor:Router()
local ONE_DAY = 24 * 3600 -- 一天的秒数

calendar_router:get("/", function(req, res, next)
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

    res:render("schoolCalendar", {
        user = result
    })
end)

calendar_router:get("/get", function(req, res, next)
	local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = true,
           
        })
    end
    local calendar = calendar_model:query(userid)
    if not calendar then
        return res:json({
            success = true,
            data = {
                schedule = schedule,
            }
        })
    end
    local total_week = calendar.total_week
    local start_time = calendar.start_time
    local semester = calendar.semester
    local schedule = {}
    start_time = time.getTimeStamp(start_time)
    for i = 1, total_week  do
        local info = {}
        local end_time = start_time + ONE_DAY * 6
        local strStartTime = time.getDateString(start_time)
        local strEndTime = time.getDateString(end_time) 
        info.startTime = strStartTime
        info.endTime = strEndTime
        info.week = i
        schedule[i] = info
        start_time = start_time + ONE_DAY * 7
    end
    res:json({
        success = true,
        data = {
            total_week = calendar.total_week,
            start_time = calendar.start_time,
            semester = semester,
            schedule = schedule,
        }
    })
end)

calendar_router:post("/get", function(req, res, next)
	local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end
    local  semester = tonumber(req.body.semester)
    local total_week = tonumber(req.body.total_week)
    local starttime = req.body.start_time
    if not calendar_model:query(userid) then
        calendar_model:new(userid, semester, req.body.start_time, total_week)
    else
        calendar_model:update(userid, semester, req.body.start_time, total_week)
    end
    local schedule = {}
    start_time = time.getTimeStamp(starttime)
    for i = 1, total_week  do
        local info = {}
        local end_time = start_time + ONE_DAY * 6
        local strStartTime = time.getDateString(start_time)
        local strEndTime = time.getDateString(end_time) 
        info.startTime = strStartTime
        info.endTime = strEndTime
        info.week = i
        schedule[i] = info
        start_time = start_time + ONE_DAY * 7
    end
    if not calendar_model:query(userid) then
        calendar_model:new(userid, semester, start_time, total_week)
    else
        calendar_model:update(userid, semester, req.body.start_time, total_week)
    end
    res:json({
        success = true,
        data = {
            schedule = schedule,
        }
    })
end)

return calendar_router
