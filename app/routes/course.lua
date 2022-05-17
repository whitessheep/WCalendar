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
local lessonplan_model = require("app.model.lessonplan")
local course_router = lor:Router()

-- user index page start
course_router:get("/add", function(req, res, next)
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

    res:render("course/add", {
        user = result
    })
end)

course_router:post("/add", function(req, res, next)
    local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end

    local coursename = req.body.coursename
    local total_period = req.body.total_period
    local theoretical_period = req.body.theoretical_period
    local experimental_period = req.body.experimental_period
    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",coursename, " total_period ",total_period, " theoretical_period ",theoretical_period, " experimental_period ",experimental_period)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local success = course_model:new(coursename, total_period, theoretical_period, experimental_period)

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

course_router:get("view", function(req, res, next)
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

    res:render("course/view", {
        user = result
    })
end)

course_router:get("/all", function(req, res, next)
    -- local page_no = req.query.page_no
    -- local topic_type = req.query.type
    -- local category = req.query.category or "0"
    -- local page_size = page_config.index_topic_page_size

    -- local total_count = topic_model:get_total_count(topic_type, category)
    -- local total_page = utils.total_page(total_count, page_size)
    -- local topics = topic_model:get_all(topic_type, category, page_no, page_size)
    local courses = course_model:get_all()
  
    res:json({
        success = true,
        data = {
            courses = courses
        }
    })
end)
-- user relation stop

course_router:get("/addLessonplan", function(req, res, next)
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

course_router:post("/addLessonplan", function(req, res, next)
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
    local success = lessonplan_model:new(semester, coursename, teachername, classname)
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

course_router:get("/viewLessonplan", function(req, res, next)
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


course_router:get("/getLessonplan", function(req, res, next)
    local lessonplan = lessonplan_model:get_all()
  
    res:json({
        success = true,
        data = {
            lessonplan = lessonplan
        }
    })
end)

course_router:get("/:coursename/delete", function(req, res, next)
    local course_id = req.params.coursename
    local userid = req.session.get("user").userid

    if not userid then
        return res:json({
            success = false,
            msg = "删除文章之前请先登录."
        })
    end

    if not course_id then
        return res:json({
            success = false,
            msg = "参数错误."
        })
    end

    local result = course_model:delete(course_id)

    if result then
        res:json({
            success = true,
            msg = "删除文章成功"
        })
    else
        res:json({
            success = false,
            msg = "删除文章失败"
        })
    end
end)

course_router:post("/update", function(req, res, next)
    local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end
    local course_id = req.body.course_id
    local coursename = req.body.coursename
    local total_period = req.body.total_period
    local theoretical_period = req.body.theoretical_period
    local experimental_period = req.body.experimental_period
    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",coursename, " total_period ",total_period, " theoretical_period ",theoretical_period, " experimental_period ",experimental_period)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local success = course_model:update(coursename, total_period, theoretical_period, experimental_period, course_id)

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
return course_router
