---------------
-- 本文件中的日期代码由网友“镜中的迷离”倾情奉献
-- 阿拉伯数字转小写代码由网友“风箫箫”倾情奉献。
-- 深山红叶合成整理
-- 请在方案配置文件比如wubi86.schema.yaml的engine\translators:下面添加滤镜引用：
-- - lua_translator@date_translator
-- - lua_translator@week_translator
-- 输入：日期/时间/星期  可查实时值




function toNyear(year,mother,day)
--天干名称
local cTianGan = {"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
--地支名称
local cDiZhi = {"子","丑","寅","卯","辰","巳","午", "未","申","酉","戌","亥"}
--属相名称
local cShuXiang = {"鼠","牛","虎","兔","龙","蛇", "马","羊","猴","鸡","狗","猪"}
--农历日期名
local cDayName =
{
"*","初一","初二","初三","初四","初五",
"初六","初七","初八","初九","初十",
"十一","十二","十三","十四","十五",
"十六","十七","十八","十九","二十",
"廿一","廿二","廿三","廿四","廿五",
"廿六","廿七","廿八","廿九","三十"
}
--农历月份名
local cMonName = {"*","正","二","三","四","五","六", "七","八","九","十","十一","腊"}


--公历每月前面的天数
local wMonthAdd = {0,31,59,90,120,151,181,212,243,273,304,334}
-- 农历数据
local wNongliData = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877}


local wCurYear,wCurMonth,wCurDay;
local nTheDate,nIsEnd,m,k,n,i,nBit;
local szNongli, szNongliDay,szShuXiang;
---取当前公历年、月、日---
wCurYear = tonumber(year);
wCurMonth = tonumber(mother);
wCurDay = tonumber(day);
---计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)---
nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth] - 38
if (((wCurYear % 4) == 0) and (wCurMonth > 2)) then
nTheDate = nTheDate + 1
end






---------------------------
--计算农历天干、地支、月、日---
nIsEnd = 0;
m = 0;
while nIsEnd ~= 1 do
if wNongliData[m+1] < 4095 then
k = 11;
else
k = 12;
end
n = k;
while n>=0 do
--获取wNongliData(m)的第n个二进制位的值
nBit = wNongliData[m+1];
for i=1,n do
nBit = math.floor(nBit/2);
end
nBit = nBit % 2;
if nTheDate <= (29 + nBit) then
nIsEnd = 1;
break
end
nTheDate = nTheDate - 29 - nBit;
n = n - 1;
end
if nIsEnd ~= 0 then
break;
end
m = m + 1;
end


wCurYear = 1921 + m;
wCurMonth = k - n + 1;
wCurDay = nTheDate;
if k == 12 then
if wCurMonth == wNongliData[m+1] / 65536 + 1 then
wCurMonth = 1 - wCurMonth;
elseif wCurMonth > wNongliData[m+1] / 65536 + 1 then
wCurMonth = wCurMonth - 1;
end
end
wCurDay = math.floor(wCurDay)
--print('农历', wCurYear, wCurMonth, wCurDay)
--生成农历天干、地支、属相 ==> wNongli--
szShuXiang = cShuXiang[(((wCurYear - 4) % 60) % 12) + 1]
szShuXiang = cShuXiang[(((wCurYear - 4) % 60) % 12) + 1];
szNongli = '农历' .. cTianGan[(((wCurYear - 4) % 60) % 10)+1] .. cDiZhi[(((wCurYear - 4) % 60) % 12) + 1] .. '（' .. szShuXiang .. '）年'
--szNongli,"%s(%s%s)年",szShuXiang,cTianGan[((wCurYear - 4) % 60) % 10],cDiZhi[((wCurYear - 4) % 60) % 12]);


--生成农历月、日 ==> wNongliDay--*/
if wCurMonth < 1 then
szNongliDay = "闰" .. cMonName[(-1 * wCurMonth) + 1]
else
szNongliDay = cMonName[wCurMonth+1]
end


szNongliDay = szNongliDay .. "月" .. cDayName[wCurDay+1]
return szNongli .. szNongliDay
end



--- date/time translator
word=0 --单字优先模式参数


function date_translator(input, seg)
-- date，年月日，日期，now
if (input == "date" or input == "rejj" or input == "jjad" or input == "now") then
--普通日期1，类似2020年02月04日
date1=os.date("%Y年%m月%d日")
date_y=os.date("%Y") --取年
date_m=os.date("%m") --取月
date_d=os.date("%d") --取日


--普通日期2，类似2020年2月4日
num_m=os.date("%m")+0
num_m1=math.modf(num_m)
num_d=os.date("%d")+0
num_d1=math.modf(num_d)
date2=os.date("%Y年")..tostring(num_m1).."月"..tostring(num_d1).."日"


--大写日期，类似二〇二〇年十一月二十六日
date_y=date_y:gsub("%d",{
["1"]="一",
["2"]="二",
["3"]="三",
["4"]="四",
["5"]="五",
["6"]="六",
["7"]="七",
["8"]="八",
["9"]="九",
["0"]="〇",
})
date_y=date_y.."年"

date_m=date_m:gsub("%d",{
["1"]="一",
["2"]="二",
["3"]="三",
["4"]="四",
["5"]="五",
["6"]="六",
["7"]="七",
["8"]="八",
["9"]="九",
["0"]="",
})
date_m=date_m.."月"
if num_m1==10 then date_m="十月" end
if num_m1==11 then date_m="十一月" end
if num_m1==12 then date_m="十二月" end

date_d=date_d:gsub("%d",{
["1"]="一",
["2"]="二",
["3"]="三",
["4"]="四",
["5"]="五",
["6"]="六",
["7"]="七",
["8"]="八",
["9"]="九",
["0"]="",
})
date_d=date_d.."日"
if num_d1>9 then
if num_d1<19 then
date_d="十"..string.sub(date_d,4,#date_d)
end
end
if num_d1>19 then date_d=string.sub(date_d,1,3).."十"..string.sub(date_d,4,#date_d) end
date3=date_y..date_m..date_d

--农历
date4=toNyear(os.date("%Y"),os.date("%m"),os.date("%d"))
date4=date4:gsub("年","年")

--星期
local day_w=os.date("%w")
local day_w1=""
if day_w=="0" then day_w1="星期日" end
if day_w=="1" then day_w1="星期一" end
if day_w=="2" then day_w1="星期二" end
if day_w=="3" then day_w1="星期三" end
if day_w=="4" then day_w1="星期四" end
if day_w=="5" then day_w1="星期五" end
if day_w=="6" then day_w1="星期六" end


yield(Candidate("date", seg.start, seg._end, date2, " "))
yield(Candidate("date", seg.start, seg._end, date3, " "))


yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), " "))
--# yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), " "))
--# yield(Candidate("date", seg.start, seg._end, date1, " ")) #这种单位数日期前面添加前缀0的格式为国家公文标准明令禁止的，不建议使用
--# yield(Candidate("date", seg.start, seg._end, day_w1, " "))
yield(Candidate("date", seg.start, seg._end, date4, " "))
end


if (input == "/11") then
-- Candidate(type, start, end, text, comment)
if (word == 0) then
word=1
yield(Candidate("date", seg.start, seg._end, "单字优先模式启用", " 配置"))
else
word=0
yield(Candidate("date", seg.start, seg._end, "单字优先模式关闭", " 配置"))
end
end
if (input == "time" or input == "jfuj") then
yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " "))
yield(Candidate("time", seg.start, seg._end, os.date("%H点%M分"), " "))
yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " "))
yield(Candidate("time", seg.start, seg._end, os.date("%H点%M分%S秒"), " "))
end


end





function week_translator(input, seg)
if (input == "week"  or input == "jtad") then
if (os.date("%w") == "0") then
weekstr = "日"
end
if (os.date("%w") == "1") then
weekstr = "一"
end
if (os.date("%w") == "2") then
weekstr = "二"
end
if (os.date("%w") == "3") then
weekstr = "三"
end
if (os.date("%w") == "4") then
weekstr = "四"
end
if (os.date("%w") == "5") then
weekstr = "五"
end
if (os.date("%w") == "6") then
weekstr = "六"
end
yield(Candidate("week", seg.start, seg._end, os.date("星期")..weekstr,""))
--#yield(Candidate("week", seg.start, seg._end, "星 g:F2A3 u:E3A2F5",""))
end
if (input == "dteg" or input == "help") then
yield(Candidate("week", seg.start, seg._end, "Control+e→颜文字开关； Control+f→简转繁开关", ""))
yield(Candidate("week", seg.start, seg._end, "Control+g→Gbk编码；   Control+u→U16编码", ""))
yield(Candidate("week", seg.start, seg._end, "Shift+Space→下键↓ ；  Control+p→拼音开关", ""))
yield(Candidate("week", seg.start, seg._end, "输入：日期、时间、星期 可得实时值", ""))
end
end






--   ["ff"] = { first = 0xE000, last = 0xF8FF },

local charset = {
   ["cjk"] = { first = 0x4E00, last = 0x9FFF },
   ["私用区"] = { first = 0xE000, last = 0xF8FF },
   ["希腊"] = { first = 0x0370, last = 0x03FF },
   ["平仮名"] = { first = 0x3040, last = 0x309F },
   ["片仮名"] = { first = 0x30A0, last = 0x30FF },
   ["cjk部首补充"] = { first = 0x2E80, last = 0x2EFF },
   ["康熙字典部首"] = { first = 0x2F00, last = 0x2FDF },
   ["cjk标点符号"] = { first = 0x3000, last = 0x303F },
   ["cjk笔画"] = { first = 0x31C0, last = 0x31EF },
   ["注音"] = { first = 0x3100, last = 0x312F },
   ["朝鲜文兼容字母"] = { first = 0x3130, last = 0x318F },
   ["cjk兼容表意文字"] = { first = 0xF900, last = 0xFAFF },
   ["拉丁补-1"] = { first = 0x0080, last = 0x00FF },
   ["拉丁扩a"] = { first = 0x0100, last = 0x017F },
   ["拉丁扩b"] = { first = 0x0180, last = 0x024F },
   ["扩A"] = { first = 0x3400, last = 0x4DBF },
   ["扩B"] = { first = 0x20000, last = 0x2A6DF },
   ["扩C"] = { first = 0x2A700, last = 0x2B73F },
   ["扩D"] = { first = 0x2B740, last = 0x2B81F },
   ["扩E"] = { first = 0x2B820, last = 0x2CEAF },
   ["扩F"] = { first = 0x2CEB0, last = 0x2EBEF },
   ["扩G"] = { first = 0x30000, last = 0x3134A },
   ["Compat"] = { first = 0x2F800, last = 0x2FA1F } }

local function exists(single_filter, text)
  for i in utf8.codes(text) do
     local c = utf8.codepoint(text, i)
     if (not single_filter(c)) then
	return false
     end
  end
  return true
end

local function is_charset(s)
   return function (c)
      return c >= charset[s].first and c <= charset[s].last
   end
end

local function is_cjk_ext(c)
   return is_charset("扩A")(c) or is_charset("扩B")(c) or
      is_charset("扩C")(c) or is_charset("扩D")(c) or
      is_charset("扩E")(c) or is_charset("扩F")(c) or
      is_charset("Compat")(c) or is_charset("扩G")(c)
end

--[[
filter 的功能是对 translator 翻译而来的候选项做修饰，
如去除不想要的候选、为候选加注释、候选项重排序等。
欲定义的 filter 包含两个输入参数：
 - input: 候选项列表
 - env: 可选参数，表示 filter 所处的环境（本例没有体现）
filter 的输出与 translator 相同，也是若干候选项，也要求您使用 `yield` 产生候选项。
如下例所示，charset_filter 将滤除含 CJK 扩展汉字的候选项：
--]]
local function charset_filter(input) --正式输出时不要带local
   -- 使用 `iter()` 遍历所有输入候选项
   for cand in input:iter() do
      -- 如果当前候选项 `cand` 不含 CJK 扩展汉字
      if (not exists(is_cjk_ext, cand.text))
      then
	 -- 结果中仍保留此候选
	 yield(cand)
      end
      --[[ 上述条件不满足时，当前的候选 `cand` 没有被 yield。
           因此过滤结果中将不含有该候选。
      --]]
   end
end


--[[
如下例所示，charset_comment_filter 为候选项加上其所属字符集的注释：
--]]
function charset_comment_filter(input)
   -- 使用 `iter()` 遍历所有输入候选项
   for cand in input:iter() do
      -- 判断当前候选内容 `cand.text` 中文字属哪个字符集
      for s, r in pairs(charset) do
	 if (exists(is_charset(s), cand.text)) then
	    --[[ 修改候选的注释 `cand.comment`
                 因复杂类型候选项的注释不能被直接修改，
                 因此使用 `get_genuine()` 得到其对应真实的候选项
            --]]
	    cand:get_genuine().comment = cand.comment .. " " .. s
	    break
	 end
      end
      -- 在结果中对应产生一个带注释的候选
      yield(cand)
   end
end

