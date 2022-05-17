-- [[ --- 用户模块 --- ]]
local pairs = pairs
local ipairs = ipairs
local smatch = string.match
local slower = string.lower
local ssub = string.sub
local slen = string.len
local utils = require("app.libs.utils")
local pwd_secret = require("app.config.config").pwd_secret
local lor = require("lor.index")
local user_model = require("app.model.user")
local notification_model = require("app.model.notification")
local course_model = require("app.model.course")
local lessonplan_model = require("app.model.lessonplan")
local teacher_model = require("app.model.teacher")
local teacher_router = lor:Router()

teacher_router:get("/addTeacher", function(req, res, next)
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

    res:render("teacher/addTeacher", {
        user = result
    })
end)

teacher_router:post("/addTeacher", function(req, res, next)
    local userid = req.session.get('user').userid
    if not userid then
        return res:json({
            success = false,
            msg = "编辑前请先登录."
        })
    end

    local username = req.body.username
    local teachername = req.body.teachername or ''
    local password = req.body.password
    local position = req.body.position or ''
    local is_admin = req.body.is_admin
    local email = req.body.email or ''
    -- ngx.log(ngx.ERR,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "coursename ",coursename, " total_period ",total_period, " theoretical_period ",theoretical_period, " experimental_period ",experimental_period)
    -- ngx.log(ngx.ERR, type(coursename), type(total_period), type(theoretical_period), type(experimental_period))
    local pattern = "[0-9a-zA-Z_]+$"
    
    local match, err = smatch(username, pattern)
    if not match then
        return res:json({
             success = false,
             msg = "用户名只能输入字母、下划线、数字."
         })
    end
     
    local result, err = user_model:query_by_username(username)
    local isExist = false
    if result and not err then
        isExist = true
    end

    if isExist == true then
        return res:json({
            success = false,
            msg = "用户名已被占用，请修改."
        })
    else
        password = utils.encode(password .. "#" .. pwd_secret)
        local avatar = ssub(username, 1, 1) .. ".png" --取首字母作为默认头像名
        avatar = slower(avatar)
        local result, err = user_model:new(username, teachername, password, avatar, position, is_admin, email)
        if result and not err then
            return res:json({
                success = true,
                msg = "添加成功."
            })  
        else
            return res:json({
                success = false,
                msg = "添加失败."
            }) 
        end
    end

end)

teacher_router:get("/viewTeacher", function(req, res, next)
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

    res:render("teacher/viewTeacher", {
        user = result
    })
end)

teacher_router:get("/all", function(req, res, next)
    local users = user_model:get_all()
  
    res:json({
        success = true,
        data = {
            users = users
        }
    })
end)

return teacher_router
