local DB = require("app.libs.db")
local db = DB:new()
local tInsert = table.insert
local lessonplan_model = {}


function lessonplan_model:new(semester, coursename, teachername, classname, total_week, start_time)
    return db:query("insert into lessonplan(semester, coursename, teachername, classname, total_week, start_time) values(?,?,?,?,?,?)",
            {semester, coursename, teachername, classname, total_week, start_time})
end

function lessonplan_model:query(lessonplan_id)
    local res, err =  db:query("select * from lessonplan where id = ?", {lessonplan_id})

    if not res or err or type(res) ~= "table" or #res ~=1 then
        return nil, err
    else
        return res[1], err
    end
            
end

function lessonplan_model:update(classname, coursename, teachername, syllabus, textbook, remark, lessonplan_id)
    return db:query("update lessonplan set classname=?, coursename=?, teachername=?, syllabus=?, textbook=?, remark=? where id=?",
            {classname, coursename, teachername, syllabus, textbook, remark, lessonplan_id})
end

function lessonplan_model:updateDetail(semester,coursename,teachername,  classname, lessonplan_id)
    return db:query("update lessonplan set semester=?, coursename=?, teachername=?, classname=? where id=?",
            {semester,coursename,teachername,  classname, lessonplan_id})
end

function lessonplan_model:delete(lessonplan)
    return db:query("delete from lessonplan where id=?",
            {tonumber(lessonplan)})
end

function lessonplan_model:get_all(state)
	local res, err
	if state then
		res, err = db:query("select * from lessonplan where state=?", {state})
	else
		res, err = db:query("select * from lessonplan ")
	end

	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end

function lessonplan_model:get_all_of_user(teachername ,state)
	local res, err
	if state then
		res, err = db:query("select * from lessonplan where teachername = ? and state = ?", {teachername, state})
	else
		res, err = db:query("select * from lessonplan where teachername = ?", {teachername})
	end

	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end

function lessonplan_model:setState(state, lessonplan_id)
	return  db:query("update lessonplan set state=? where id=?", {state, lessonplan_id})
end

function lessonplan_model:query_all(semester,coursename,teachername,classname)
	local res, err
	local isFirst = true
	local sqlStr = "select * from lessonplan "
	local sqlPar = {}
	if semester ~= '' then
		sqlStr = sqlStr .. "where semester = ? "
		tInsert(sqlPar, semester)
		isFirst = false
	end
	if coursename ~= '' then
		if not isFirst then
			sqlStr = sqlStr .. "and "
		else
			sqlStr = sqlStr .. "where "
		end
		sqlStr = sqlStr .. "coursename = ? "
		tInsert(sqlPar, coursename)
		isFirst = false
	end
	if teachername ~= '' then
		if not isFirst then
			sqlStr = sqlStr .. "and "
		else
			sqlStr = sqlStr .. "where "
		end
		sqlStr = sqlStr .. "teachername = ? "
		tInsert(sqlPar, teachername)
		isFirst = false
	end
	if classname ~= '' then
		if not isFirst then
			sqlStr = sqlStr .. "and "
		else
			sqlStr = sqlStr .. "where "
		end
		sqlStr = sqlStr .. "classname = ? "
		tInsert(sqlPar, classname)
		isFirst = false
	end
	res, err = db:query(sqlStr, sqlPar)
	if not res or err or type(res) ~= "table" or #res <= 0 then
		return {}
	else
		return res
	end
end
return lessonplan_model
