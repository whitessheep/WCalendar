local DB = require("app.libs.db")
local db = DB:new()

local calendar_model = {}


function calendar_model:new(user_id, semester, start_time, total_week)
    return db:query("insert into calendar(user_id, semester, start_time, total_week) values(?,?,?,?)",
            {user_id, semester, start_time, total_week})
end

function calendar_model:query(id)
    local res, err =  db:query("select * from calendar where user_id = ?", {id})

    if not res or err or type(res) ~= "table" or #res ~=1 then
        return nil, err
    else
        return res[1], err
    end
end

function calendar_model:update(user_id, semester, start_time, total_week)
    return db:query("update calendar set user_id=?, semester=?, start_time=?, total_week=?",
            {user_id, semester, start_time, total_week})
end



return calendar_model
