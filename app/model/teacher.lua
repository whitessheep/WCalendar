local DB = require("app.libs.db")
local db = DB:new()

local teacher_model = {}
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

function teacher_model:new(username, teachername, password, position, is_admin, email, sign)
    return db:query("insert into teacher(username, teachername, password, position, is_admin, email, sign) values(?,?,?,?,?,?,?)",
            {username, teachername, password, position, is_admin, email, sign})
end

function teacher_model:get_all()
	local res, err = db:query("select * from teacher")

	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end

return teacher_model
