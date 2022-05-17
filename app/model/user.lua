local DB = require("app.libs.db")
local db = DB:new()

local user_model = {}
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

function user_model:new(username, teachername, password, avatar, position, is_admin, email)
    return db:query("insert into user(username, teachername, password, avatar, position, is_admin, email) values(?,?,?,?,?,?,?)",
            {username, teachername, password, avatar, position, is_admin, email})
end

function user_model:get_all()
	local res, err = db:query("select * from user")

	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end

function user_model:query_ids(usernames)
   local res, err =  db:query("select id from user where username in(" .. usernames .. ")")
   return res, err
end

function user_model:query(username, password)
   local res, err =  db:query("select * from user where username=? and password=?", {username, password})
   return res, err
end

function user_model:query_by_id(id)
    local result, err =  db:query("select * from user where id=?", {tonumber(id)})
    if not result or err or type(result) ~= "table" or #result ~=1 then
        return nil, err
    else
        return result[1], err
    end
end

-- 查找用户
function user_model:query_by_username(username)
   	local res, err =  db:query("select * from user where username=? limit 1", {username})
   	if not res or err or type(res) ~= "table" or #res ~=1 then
		return nil, err or "error"
	end

	return res[1], err
end

function user_model:query_by_teachername(teachername)
    local res, err =  db:query("select * from user where teachername=? limit 1", {teachername})
    if not res or err or type(res) ~= "table" or #res ~=1 then
     return nil, err or "error"
 end

 return res[1], err
end

function user_model:update_avatar(userid, avatar)
    db:query("update user set avatar=? where id=?", {avatar, userid})
end

function user_model:update_pwd(userid, pwd)
    local res, err = db:query("update user set password=? where id=?", {pwd, userid})
    if not res or err then
        return false
    else
        return true
    end

end

function user_model:update(userid, email, teachername, position, sign)
    local res, err = db:query("update user set email=?, teachername=?, position=?, sign=? where id=?", 
    { email, teachername, position, sign, userid})
    if not res or err then
        return false
    else
        return true
    end
end

function user_model:delete(userid)
    local res, err = db:query("delete from user where id=?", 
    {tonumber(userid)})
    if not res or err then
        return false
    else
        return true
    end
end

function user_model:updateDetail(teachername, password, position, is_admin, email, username)
    local res, err = db:query("update user set teachername=?, password=?, position=?, is_admin=?, email=? where username=?", 
    {teachername, password, position, is_admin, email, username})
    if not res or err then
        return false
    else
        return true
    end
end

function user_model:get_total_count()
    local res, err = db:query("select count(id) as c from user")

    if err or not res or #res~=1 or not res[1].c then
        return 0
    else
        return res[1].c
    end
end


return user_model
