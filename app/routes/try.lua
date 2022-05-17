-- [[ --- 课程模块 --- ]]
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
local try_router = lor:Router()

-- user index page start
try_router:get("/:lessonplan/preview", function(req, res, next)
    local lessonplan_id = req.params.lessonplan
    local lessonplan = lessonplan_model:query(tonumber(lessonplan_id))
    local teachername = lessonplan.teachername
    local teacher, err = user_model:query_by_teachername(teachername)
    local schedules = schedule_model:getAllByLessonpanID(lessonplan_id)
    lessonplan.lecture_period = 0
    lessonplan.experiment_period = 0
    lessonplan.exercise_period = 0
    lessonplan.disscussion_period = 0
    lessonplan.other_period = 0
    lessonplan.total = 0
    for _, info in ipairs(schedules) do
        lessonplan.lecture_period = lessonplan.lecture_period + info.lecture_period
        lessonplan.experiment_period = lessonplan.experiment_period + info.experiment_period
        lessonplan.exercise_period = lessonplan.exercise_period + info.exercise_period
        lessonplan.disscussion_period = lessonplan.disscussion_period + info.disscussion_period
        lessonplan.other_period = lessonplan.other_period + info.other_period
    end
    lessonplan.total = lessonplan.lecture_period + lessonplan.experiment_period + lessonplan.exercise_period + lessonplan.disscussion_period + lessonplan.other_period
    ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", lessonplan.start_time, type(lessonplan.start_time))
    res:render("tryView", {
        lessonplan = lessonplan,
        schedules = schedules,
        teacher = teacher,
    })
end)


return try_router
