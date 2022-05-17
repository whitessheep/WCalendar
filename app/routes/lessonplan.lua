-- [[ --- 用户模块 --- ]]
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
local lessonplan_router = lor:Router()

lessonplan_router:get("/view", function(req, res, next)
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

    res:render("course/viewLessonplan", {
        user = result
    })
end)

lessonplan_router:get("/get_all", function(req, res, next)
    local user_id = req.session.get("user").userid
	if not user_id or user_id == 0 then
		return res:render("error", {
			errMsg = "cannot find user, please login."
		})
	end
    local type = req.query.type
    local lessonplan = lessonplan_model:get_all(type)
    res:json({
        success = true,
        data = {
            lessonplan = lessonplan
        }
    })
end)

lessonplan_router:get("/add", function(req, res, next)
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

    res:render("course/addLessonplan", {
        user = result
    })
end)

lessonplan_router:post("/add", function(req, res, next)
    local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end
    local semester = req.body.semester
    local coursename = req.body.coursename
    local teachername = req.body.teachername
    local classname = req.body.classname
    local total_week = req.body.total_week
    local start_time = req.body.start_time
    local success = lessonplan_model:new(semester, coursename, teachername, classname, total_week, start_time)
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

lessonplan_router:get("/my", function(req, res, next)
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
    
    res:render("lessonplan/myLessonplan", {
        user = result
    })
end)


lessonplan_router:get("/get_user_all", function(req, res, next)
    local teachername = req.session.get("user").teachername
    local user_id = req.session.get("user").userid
	if not user_id or user_id == 0 then
		return res:render("error", {
			errMsg = "cannot find user, please login."
		})
	end
    local lesson_type = req.query.type
    local lessonplan = lessonplan_model:get_all_of_user(teachername, lesson_type)
  
    res:json({
        success = true,
        data = {
            lessonplan = lessonplan
        }
    })
end)


lessonplan_router:get("/:lessonplan/fill", function(req, res, next)
    local lessonplan_id = req.params.lessonplan
    local lessonplan = lessonplan_model:query(tonumber(lessonplan_id))
    local user_id = req.session.get("user").userid
    local result, err = user_model:query_by_id(user_id)
  
    res:render("lessonplan/fill", {
        lessonplan = lessonplan,
        user = result
    })
end)


lessonplan_router:post("/fill", function(req, res, next)
    local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end
    local lessonplan_id = req.body.lessonplan_id
    local classname = req.body.classname
    local coursename = req.body.coursename
    local teachername = req.body.teachername
    local syllabus = req.body.syllabus
    local textbook = req.body.textbook
    local remark = req.body.remark

    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",semester, " total_period ",coursename, " theoretical_period ",teachername, " experimental_period ",classname)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local success = lessonplan_model:update(classname, coursename, teachername, syllabus, textbook, remark, lessonplan_id)

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

lessonplan_router:get("/schedule", function(req, res, next)
    local lessonplan_id = req.query.lessonplan_id
    local week = req.query.week
    local schedule = schedule_model:query(lessonplan_id, week)
    if not schedule then
        local result, err = schedule_model:new(lessonplan_id, week)
        if not result or err then
            return res:json({
                success = false,
                msg = "create schedule error"
            })
        end
        schedule = {}
    end
    res:json({
        success = true,
        data = {
            schedule = schedule
        }
    })
end)

lessonplan_router:post("/schedule", function(req, res, next)
    local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end
    local lessonplan_id = req.body.lessonplan_id
    local lecture_period = req.body.lecture_period
    local experiment_period = req.body.experiment_period
    local exercise_period = req.body.exercise_period
    local disscussion_period = req.body.disscussion_period
    local other_period = req.body.other_period
    local week = req.body.week
    local content = req.body.content

    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",semester, " total_period ",coursename, " theoretical_period ",teachername, " experimental_period ",classname)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local success = schedule_model:update(content, lecture_period, experiment_period, exercise_period, disscussion_period, other_period, week, lessonplan_id)

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

lessonplan_router:get("/:lessonplan/preview", function(req, res, next)
    local user_id = req.session.get("user").userid
    
    local lessonplan_id = req.params.lessonplan
    if not user_id or not lessonplan_id then
        return res:json({
            success = false,
            msg = "参数请求错误."
        })
    end
    local lessonplan = lessonplan_model:query(tonumber(lessonplan_id))
    local teachername = lessonplan.teachername
    local result, err = user_model:query_by_id(user_id)
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
    res:render("teacherCalendar", {
        user = result,
        lessonplan = lessonplan,
        schedules = schedules,
        teacher = teacher,
    })
end)



lessonplan_router:get("/viewmy", function(req, res, next)
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
    
    res:render("lessonplan/viewMy", {
        user = result
    })
end)

lessonplan_router:get("/:lessonplan/delete", function(req, res, next)
    local lessonplan = req.params.lessonplan
    local userid = req.session.get("user").userid

    if not userid then
        return res:json({
            success = false,
            msg = "删除文章之前请先登录."
        })
    end

    if not lessonplan then
        return res:json({
            success = false,
            msg = "参数错误."
        })
    end

    local result = lessonplan_model:delete(lessonplan)

    if result then
        res:json({
            success = true,
            msg = "删除成功"
        })
    else
        res:json({
            success = false,
            msg = "删除失败"
        })
    end
end)

lessonplan_router:post("/update", function(req, res, next)
    local userid = req.session.get("user").userid

    if not userid then
        return res:json({
            success = false,
            msg = "请先登录."
        })
    end

    local semester = req.body.semester
    local coursename = req.body.coursename
    local teachername = req.body.teachername
    local classname = req.body.classname
    local lessonplan_id = req.body.lessonplan_id
    local result = lessonplan_model:updateDetail(semester,coursename,teachername,  classname, lessonplan_id)

    if result then
        res:json({
            success = true,
            msg = "成功"
        })
    else
        res:json({
            success = false,
            msg = "失败"
        })
    end
end)

lessonplan_router:get("/find", function(req, res, next)

    local semester = req.query.semester
    local coursename = req.query.coursename
    local teachername = req.query.teachername
    local classname = req.query.classname
    local result = lessonplan_model:query_all(semester,coursename,teachername,  classname)

    res:json({
        success = true,
        data = {
            lessonplan = result
        }
    })
end)

return lessonplan_router
