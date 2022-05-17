local DB = require("app.libs.db")
local db = DB:new()

local schedule_model = {}


function schedule_model:new(lessonplan_id, week)
    return db:query("insert into schedule(lessonplan_id, week) values(?,?)",
            {lessonplan_id, week})
end

function schedule_model:query(lessonplan_id, week)
    local res, err =  db:query("select * from schedule where lessonplan_id=? and week=?", {lessonplan_id, week})

    if not res or err or type(res) ~= "table" or #res ~=1 then
        return nil, err
    else
        return res[1], err
    end
            
end

function schedule_model:update(content,lecture_period,experiment_period,exercise_period,disscussion_period,other_period, week, lessonplan_id)
    return db:query("update schedule set content=?, lecture_period=?, experiment_period=?, exercise_period=?, disscussion_period=?, other_period=? where lessonplan_id=? and week=?",
            {content,lecture_period,experiment_period,exercise_period,disscussion_period,other_period,lessonplan_id, week})
end

function schedule_model:getAllByLessonpanID(lessonplan_id)
	local res, err = db:query("select * from schedule where lessonplan_id = ? order by week", {lessonplan_id})

	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end

return schedule_model
