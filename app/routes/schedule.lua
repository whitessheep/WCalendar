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
local schedule_model = require("app.model.schedule")
local lessonplan_model = require("app.model.lessonplan")
local schedule_router = lor:Router()
local ONE_DAY = 24 * 3600 -- 一天的秒数

schedule_router:get("/get", function(req, res, next)
    local lessonplan_id = req.query.lessonplan_id
    local schedule = schedule_model:getAllByLessonpanID(lessonplan_id)
    local lessonplan = lessonplan_model:query(tonumber(lessonplan_id))
    local start_time = time.getTimeStamp(lessonplan.start_time)
    for i, info in pairs(schedule) do
        local end_time = start_time + ONE_DAY * 6
        local strStartTime = time.getDateString(start_time)
        local strEndTime = time.getDateString(end_time) 
        -- ngx.log(ngx.ERR, ' ', strStartTime, ' ', type(strStartTime), ' ', strEndTime, ' ', type(strEndTime))
        info.startTime = strStartTime
        info.endTime = strEndTime
        -- ngx.log(ngx.ERR, ' ', info.startTime, ' ', type(info.startTime), ' ', info.endTime, ' ', type(info.endTime))
        start_time = start_time + ONE_DAY * 7
    end
    res:json({
        success = true,
        data = {
            schedule = schedule,
            remark = lessonplan.remark
        }
    })
end)
return schedule_router
