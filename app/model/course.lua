local DB = require("app.libs.db")
local db = DB:new()

local course_model = {}
--[[
    follow = {
    | id           | int unsigned
    | username     | varchar(50)
    | password     | varchar(255)
    | avatar       | varchar(500) 头像
    | create_time  | timestamp    注册时间                   
    | city         | varchar(11) 
    | website      | varchar(255)
    | company      | varchar(100)
    | sign         | varchar(255)
    | github       | varchar(30) 
    | email        | varchar(200)
    | email_public | int          1公开，0私密
    | is_admin     | int          1管理员，0普通用户
   }
]]

function course_model:new( coursename, total_period, theoretical_period, experimental_period)
    return db:query("insert into course(coursename, total_period, theoretical_period, experimental_period) values(?,?,?,?)",
            {coursename, total_period, theoretical_period, experimental_period})
end

function course_model:update( coursename, total_period, theoretical_period, experimental_period, course_id)
    return db:query("update course set coursename=?, total_period=?, theoretical_period=?, experimental_period=? where id=?",
            {coursename, total_period, theoretical_period, experimental_period, course_id})
end

function course_model:get_all()
	local res, err = db:query("select * from course")

	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end

function course_model:get_coursename()
	local res, err = db:query("select coursename from course")

	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end

function course_model:queryByCoursename(coursename)
	local res, err = db:query("select * from course where coursename = ?", {coursename})

    if not res or err or type(res) ~= "table" or #res ~=1 then
        return nil, err
    else
        return res[1], err
    end
end

function course_model:delete(course_id)
    local res, err = db:query("delete from course where id=?",
            {tonumber(course_id)})
    if res and not err then
    	return true
    else
    	return false
    end
end
return course_model
