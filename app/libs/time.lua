local osTime = os.time
local osDate = os.date
local mathFloor = math.floor

local TIME_BASE = 1072886400 --2004年1月1日 00:00 星期四
local ONE_DAY = 24 * 3600 -- 一天的秒数
local NONE_DAY = 0
local time = {}
time.oneDaySec = ONE_DAY 

-- "2019-07-11 00:00:00" 转为时间戳
function time.getTimeStamp(timestr)
    local spfunc = string.gmatch(timestr, "%d+")
    local datetbl = {}
    datetbl.year = spfunc() or osDate("%Y")
    datetbl.month = spfunc() or osDate("%m")
    datetbl.day = spfunc() or osDate("%d")
    datetbl.hour = spfunc() or nil -- 默认为12
    datetbl.min = spfunc() or nil -- 默认为0
    datetbl.sec = spfunc() or nil -- 默认为0

    return osTime(datetbl)
end

-- 获取日期字符串 "2019-07-11"
function time.getDateString(timeStamp)
    timeStamp = timeStamp or osTime()
    local tmp = ''
    tmp = tmp .. tostring(tonumber(osDate("%m", timeStamp))) .. '月'
    tmp = tmp .. osDate("%d", timeStamp) .. '日'
    return tmp
end

return time