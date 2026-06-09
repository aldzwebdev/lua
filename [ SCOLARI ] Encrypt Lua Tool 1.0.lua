local g = {}
g.last = gg.getFile()
g.info = nil
g.config = gg.EXT_CACHE_DIR .. "/" .. gg.getFile():match("[^/]+$") .. "cfg"

DATA = loadfile(g.config)
if DATA ~= nil then
    g.info = DATA()
    DATA = nil
end

if g.info == nil then
    g.info = {g.last, g.last:gsub("/[^/]+$", "")}
end

opensc = gg.alert(os.date([[
-------------------------------------------------
  ENCRYPTION LUA V1
-------------------------------------------------

Protect Encrypt Lua V1

* Big log - Anti hook
* Crash sstool - Big lasm
* Error lasm + Dump lasm
* Memory Bomb
* Timing Attack Detection
* Detect SSTool
* Integrity Check
* Runtime Encryption

Power by: 
Telegram @ScolariOfficial
Telegram Channel @ScolariChannel

-------------------------------------------------
  ENCRYPTION LUA V1
-------------------------------------------------
]]), "OPEN", "EXIT")

if opensc == nil then end
if opensc == 1 then end
if opensc == 2 then
    os.exit(print(os.date([[Script Cancel]])))
end

while true do
    g.info = gg.prompt({
        "Select File",
        "Select Path",
        "Add Protect V1 ( Don't Select Protect V2)\n- Big Log\n- Anti Hook\n- Anti GG Log",
        "Add Protect V2 (Don't Select Protect V1)\n- Detect Environment\n- Memory Bomb\n- Timing Attack Detection\n- Detect SSTool\n- Integrity Check\n- Runtime Encryption\n- Big Lasm V2\n- Anti Hook V2\nAnti Debug",
        "Add Expired Date",
        "Add Password",
        "Add Game Guardian Version",
        "Add Rename Blocked",
        "Add Package Game Guardian",
        "Add Package Game",
    }, g.info, {
        "file",
        "path",
        "checkbox",
        "checkbox",
        "checkbox",
        "checkbox",
        "checkbox",
        "checkbox",
        "checkbox",
        "checkbox",
    })

    if g.info == nil then
        gg.toast([[Encrypt Cancel by User..]])
        os.exit()
    end

    gg.saveVariable(g.info, g.config)

    DATA = io.input(g.info[1]):read("*a")
    if not load(DATA) then
        os.exit()
    end

    g.last = g.info[1]
    g.out = g.last:match("[^/]+$")
    g.out = g.out:gsub(".lua", "._enc")
    g.out = g.info[2] .. '/' .. g.out .. '.lua'

    gg.toast("Start Encrypt Wait...")

    function RandomGarb(sz, isF)
        sz = sz or math.random(8, 58)
        local se = " goto s "
        local strs = ""
        for s = 1, 58 do
            strs = strs .. se
        end
        strs = " if nil then " .. strs .. " ::s:: end "
        return strs
    end

    function RandomLitter(Num)
        local M
        if Num == 1 then
            M = (function(...) return string.char((...)[2], (...)[1], (...)[1], (...)[1]) end)({0, 1})
        elseif Num == 2 then
            M = (function(...) return string.char((...)[1]) end)({1}) ..
                (function(...) return string.char(math.random((...)[2], (...)[1] .. (...)[3])) end)({3, 0, 3}) ..
                (function(...) return string.char((...)[1], (...)[1]) end)({0})
        elseif Num == 3 then
            M = (function(...) return string.char((...)[1], (...)[2], (...)[3], (...)[4]) end)({173, 240, 159, 135})
        elseif Num == 4 then
            M = (string.char(math.random(47, 63)) .. (function(...) return string.char((...)[1], (...)[2], (...)[3]) end)({240, 159, 135}))
        elseif Num == 5 then
            M = (string.char(math.random(111, 127)) .. (function(...) return string.char((...)[1], (...)[2], (...)[3]) end)({240, 159, 135}))
        elseif Num == 6 then
            M = (string.char(math.random(173, 191)) .. (function(...) return string.char((...)[1], (...)[2], (...)[3]) end)({240, 159, 135}))
        elseif Num == 7 then
            M = (string.char(math.random(239, 255)) .. (function(...) return string.char((...)[1], (...)[2], (...)[3]) end)({240, 159, 135}))
        elseif Num == 8 then
            M = (string.char(167) .. (function(...) return string.char(math.random((...)[2], (...)[1]), math.random((...)[2], (...)[1]), math.random((...)[2], (...)[1])) end)({33, 0, 167}))
        elseif Num == 9 then
            M = (function(...) return string.char((...)[1], (...)[2], (...)[3], (...)[4]) end)({172, 240, 159, 135})
        end
        return M
    end

    function enc(str)
        local gb = {str:byte(1, -1)}
        for i = 1, #gb do
            gb[i] = (gb[i] - 1 - (1 + i) * (1 + i)) % 256
        end
        return "{" .. table.concat(gb, ",") .. "}"
    end

    local scoenc = [[
function ScolariOfficial(c)
    local res = ''
    for i in ipairs(c) do
        res = res .. string.char((c[i] + 1 + (1 + i) * (1 + i)) % 256)
    end
    return res
end
]]

    DATA = DATA:gsub('"(.-)"', function(c)
        c = load('return "' .. c .. '"')()
        local T = enc(c)
        return "ScolariOfficial(" .. T .. ")"
    end)

    DATA = DATA:gsub("'(.-)'", function(c)
        c = load("return '" .. c .. "'")()
        local T = enc(c)
        return 'ScolariOfficial(' .. T .. ')'
    end)

    for G, v in pairs(gg) do
        local TDTV = "gg." .. G
        DATA = DATA:gsub(TDTV, function()
            local A = enc(G)
            return "gg[ScolariOfficial(" .. A .. ")]"
        end)
    end

    local KS = {"print%(", "load%(", "loadfile%("}
    for i = 1, #KS do
        DATA = DATA:gsub(KS[i], function(c)
            c = c:gsub("%(", "")
            local T = enc(c)
            return "_G[ScolariOfficial(" .. T .. ")]("
        end)
    end

    for G, v in pairs(os) do
        local TDTV = "os." .. G
        DATA = DATA:gsub(TDTV, function()
            local A = enc(G)
            return "os[ScolariOfficial(" .. A .. ")]"
        end)
    end

    for G, v in pairs(io) do
        local TDTV = "io." .. G
        DATA = DATA:gsub(TDTV, function()
            local A = enc(G)
            return "io[ScolariOfficial(" .. A .. ")]"
        end)
    end

    for G, v in pairs(string) do
        local TDTV = "string." .. G
        DATA = DATA:gsub(TDTV, function()
            local A = enc(G)
            return "string[ScolariOfficial(" .. A .. ")]"
        end)
    end

    for G, v in pairs(math) do
        local TDTV = "math." .. G
        DATA = DATA:gsub(TDTV, function()
            local A = enc(G)
            return "math[ScolariOfficial(" .. A .. ")]"
        end)
    end

    for G, v in pairs(table) do
        local TDTV = "table." .. G
        DATA = DATA:gsub(TDTV, function()
            local A = enc(G)
            return "table[ScolariOfficial(" .. A .. ")]"
        end)
    end

    for G, v in pairs(debug) do
        local TDTV = "debug." .. G
        DATA = DATA:gsub(TDTV, function()
            local A = enc(G)
            return "debug[ScolariOfficial(" .. A .. ")]"
        end)
    end

    DATA = DATA:gsub("ggetRngesList", "gg.getRangesList")

    DATA = scoenc .. DATA

    if not load(DATA) then
        gg.alert("Can't throw away a script? please double check the script.", "Exit")
        os.exit()
    end

    local big = 'B = "MeXxMx"\n'
    big = big:rep(123456)

    if g.info[3] == true then
      print("✔️ Protect V1 - Big Log - Anti Hook - Anti GG Log Succes added....")
        DATA = ([[

local C = string.rep(" ScolariOfficial ", 2002)
local Check = {}
for i = 1, 1234 do
    Check[i] = C
end

for A, B in pairs({
    gg.alert,
    gg.bytes,
    gg.copyText,
    gg.searchAddress,
    gg.searchNumber,
    gg.toast
}) do
    local a = pcall(B, Check)
end

local Q = 0

local LOG = os.clock()
local Spam = string.char(239, 191, 189):rep(100)
for i = 1, 9000 do
    debug.getinfo(i, nil, Spam)
end
local LOGD = os.clock() - LOG
if LOGD <= 1 then else end

if (nil) then (function() end)() end
if true then else return end
if true then else return end

if os.time() > os.time() then return end
if os.time() < os.time() then end
if os.difftime(os.time(), (os.time())) > 2 then return end
if os.clock() > os.clock() then return end
if os.clock() < os.clock() then end
if os.difftime(os.clock(), (os.clock())) > 2 then return end

local function loader(str)
    local i = ""
    repeat
        i = i .. string.char(math.random(97, 122))
    until #i > 10
    package.path = "?"
    local ii = (gg.EXT_STORAGE) .. "/" .. i
    io.open(ii, "w"):write(str)
    i = 0
    local iii = function()
        load("ScolariOfficialLoad")
        i = i + 1
        if i > 1 then
            io.open(ii, "w"):write(str)
            os.remove(ii)
            debug.sethook(iii, "")
        end
    end
    debug.sethook(iii, "cr")
    local iiii = pcall(require, ii)
    return
end

while (nil) do
    local o = {}
    if (o.o) then
        if (o.o.o) then
            o.o = (o.o(o))
            o.o = (o.o(o.o.o(o.o(o))))
        end
    end
end

if nil ~= nil then
    local _T = (-nil)((-nil)[nil] | nil | nil)
    local _B = _T
    _B = _B()
    while (nil) do _B() end
    if _B ~= nil then
        do
            for i = 0, 1, 0 do
                local _C = _C()
                _C = _Cnil
                _C = _C():_C(_Cnil)(_Cnil * -1) .. _Cnil
                _C = _C(_Cnil)(_C)
            end
            for p = 0, 1, 0 do
                if nil ~= nil then
                    (-nil)((-nil)[nil] | nil | nil)
                    (-nil)((-nil)[nil] | nil | nil)
                    local _L = {
                        (-nil)((-nil)[nil] | nil | nil),
                        (nil * (-nil)),
                        (-nil)((-nil)[nil] | nil | nil) * (-nil)((-nil)[nil] | nil | nil) / (-nil)((-nil)[nil] | nil | nil) % (-nil)((-nil)[nil] | nil | nil)
                    }
                    _L = _L()
                    _L = _Lnil
                    _L = _L():_L(_Lnil)(_Lnil * -1) .. _Lnil
                    _L = _L(_Lnil)(_L)
                    if _L ~= nil then
                        _L = _(_Lnil * nil)
                        _L = nil
                    end
                    if _L == nil then
                        _L = {_L(_L * nil)(_L * nil)(nil * 1, 1 << nil), _L * nil}
                    end
                end
                local _T = {}
                x[""] = T
                local K = (x)(x, x)
                K[1] = 1
            end
            local x = {}
            x[""] = x
            local t = (x)(x, x)
            t[1] = 1
        end
        _ = {_, _(-nil)(-nil)(nil * 1, 1 << nil), -nil}
        _ = _(nil)
        _ = -nil
        _ = _(-nil * nil)()
        _C = _C(_)
        _C = {
            (-nil)((-nil)[nil] | nil | nil),
            (nil * (-nil)),
            (-nil)((-nil)[nil] | nil | nil) * (-nil)((-nil)[nil] | nil | nil) / (-nil)((-nil)[nil] | nil | nil) % (-nil)((-nil)[nil] | nil | nil)
        }
        _C = _C()
        if _C == nil then
            _C = {_C(_C * nil)(_C * nil)(nil * 1, 1 << nil), _C * nil}
        end
        while _B ~= _C do
            if _T ~= _C then
                do
                    for _ = 1, 56 do _C() end
                end
            end
        end
    end
    while _B ~= nil do
        _C = nil, nil, nil, nil
    end
end

local log = {}
for i = 1, 20000 do
    table.insert(log, {address = 127 + i, flags = 12, values = 127})
end

if debug.traceback == nil then
    print("Error 0x00004")
    return
end

local v = math.random(10, 50)
if debug.getinfo(gg.alert).source ~= "=[Java]" then
    local s = string.char(90, 255):rep(999999)
    for i = 1, 1200 do
        debug.getinfo(1, nil, s)
    end
    return gg.alert("Error Code : 0x0000" .. v .. "", "")
end

if string.rep("a", 2) ~= "aa" then
    gg.alert("Rep Fail")
    Fail()
end

local _0 = string.rep("_0", 2)
if _0 == "_0_0" then
else
    local _l = math.random(100000, 100000)
    local _9 = math.random(10, 20)
    local _1 = string.char(255, 122, 255, 122, 0, 4, 8) .. _l
    _1 = _1:rep(999)
    for i = 1, #_1 do
        debug.getinfo(1, nil, nil, _1)
    end
    return gg.alert("WARNING")
end

local AntiLoad = function(code)
    local Num = 0
    local TakeCode = function(Code)
        local num2 = Num + 1
        Num = num2
        return code[Num]
    end
    return TakeCode
end
local code = {" ", " ", " "}
assert(load(AntiLoad(code)))()

_ENV["debug"]["getinfo"] = function(a)
    return _ENV["debug"]["getinfo"]("CCXCCX")
end

]]) .. DATA
    end

if g.info[4] == true then
      print("✔️ Protect V2 - Detect Enviroment - Memory Bomb - Timing Attack Detection - Detect SSTool - Integrity Check - Runtime Encryption - Big Lasm V2 - Anti Hook V2 - Anti Debug Succes added..")
        local ProtectV2 = [[
   do
local function detectEnvironment()
    local env = {}
    env.isGG = pcall(function() return gg.getFile() end)
    env.isLuaJIT = type(jit) == "table"
    local info = debug.getinfo(1, "S")
    env.isDebuggable = info and info.source and info.source:find("debug")
    return env
end

local function memoryBomb()
    local bomb = "X"
    for i = 1, 28 do bomb = bomb .. bomb end
    local function recursiveTable(depth) local t = {} if depth > 0 then t[1] = recursiveTable(depth - 1) end return t end
    recursiveTable(10000)
    local function stackOverflow(n) if n == 0 then return end return stackOverflow(n - 1) end
    stackOverflow(100000)
    local hugeTable = {} for i = 1, 1000000 do hugeTable[i] = string.rep("A", 10000) end
end

local function timingAttackDetection()
    local startTime = os.clock()
    local dummy = 0
    for i = 1, 100000 do dummy = dummy + i end
    if os.clock() - startTime > 0.5 then memoryBomb() os.exit() end
    local function measureTime(func) local t1=os.clock() func() local t2=os.clock() return t2-t1 end
    local normalTime = measureTime(function() local x=0 for i=1,1000 do x=x+i end end)
    if normalTime > 0.1 then error("Debugger detected") end
end

local function detectSSTool()
    local sstoolPaths = {"/data/local/tmp/sstool", "/sdcard/sstool", gg.EXT_STORAGE .. "/sstool"}
    for _, path in pairs(sstoolPaths) do
        local f = io.open(path, "r")
        if f then f:close() memoryBomb() end
    end
end

local function integrityCheck()
    local scriptSource = debug.getinfo(1, "S").source
    local originalHash = 0
    for i = 1, #scriptSource do originalHash = (originalHash + string.byte(scriptSource, i)) % 65535 end
    local function verify()
        local currentSource = debug.getinfo(1, "S").source
        local currentHash = 0
        for i = 1, #currentSource do currentHash = (currentHash + string.byte(currentSource, i)) % 65535 end
        if currentHash ~= originalHash then memoryBomb() end
    end
    debug.sethook(verify, "l", 100)
end

local function runtimeEncryption()
    local keys = {0xAA, 0x55, 0x78, 0x9F, 0x3C, 0x4E}
    local function xorDecrypt(data)
        local result = {}
        for i = 1, #data do
            local byte = string.byte(data, i)
            byte = byte ~ keys[(i - 1) % #keys + 1]
            result[i] = string.char(byte)
        end
        return table.concat(result)
    end
    local criticalStrings = { xorDecrypt("\xcb\x14\x2a\x11\x09") }
    if criticalStrings[1] ~= "crash" then memoryBomb() end
end

local function generateBigLasm()
    local lasm = {}
    for i = 1, 10000 do
        local rand = math.random(1, 10)
        if rand == 1 then
            lasm[i] = string.format("local _%d_%d = function(x) return x + %d end", i, math.random(9999), math.random(1000))
        elseif rand == 2 then
            lasm[i] = string.format("local t%d = {%s}", i, string.rep("0,", 100):sub(1, -2))
        elseif rand == 3 then
            lasm[i] = string.format("if %d > %d then goto skip_%d else goto skip_%d end ::skip_%d::", math.random(100), math.random(100), i, i, i)
        elseif rand == 4 then
            lasm[i] = string.format("do local x=%d; while x>0 do x=x-1 end end", math.random(10000))
        elseif rand == 5 then
            lasm[i] = string.format("local s='%s'; s=s:rep(%d)", string.rep("X", math.random(10)), math.random(100))
        else
            lasm[i] = string.format("-- JUNK_LINE_%d_%d", i, math.random(99999))
        end
    end
    return table.concat(lasm, "\n")
end

local function antiHook()
    local function isHooked(func)
        local info = debug.getinfo(func, "u")
        return info and info.nups == 0 and func ~= print
    end
    local functionsToCheck = {print, error, io.write, string.gsub, table.insert, math.random}
    for _, func in pairs(functionsToCheck) do
        if isHooked(func) then while true do end end
    end
end

    local function isDebugged()
        local t1 = os.clock()
        local x = 0
        for i = 1, 100000 do x = x + i end
        local t2 = os.clock()
        if t2 - t1 > 0.3 then return true end
        
        local info = debug.getinfo(1, "S")
        if info and info.source and info.source:find("debug") then return true end
        
        return false
    end
    
    if isDebugged() then
        gg.alert("Debugger detected! Script protected.")
        os.exit()
    end
    
    local oldGetInfo = debug.getinfo
    debug.getinfo = function(...)
        local args = {...}
        if args[2] and args[2] == "S" then
            return nil
        end
        return oldGetInfo(...)
    end
end
]]
   
       DATA = ProtectV2 .. DATA
       end
    
    if g.info[5] == true then
        local day = os.date("%d")
        local exp_date = gg.prompt({
            "Set Expired Date : ",
            "Type Expired Message : "
        }, {
            os.date("%Y%m" .. day + 7),
            "Script Expired"
        }, {"number", "text"})

        if not exp_date then
            gg.setVisible(true)
        elseif exp_date[1] == nil then
            gg.alert("Date Can Not Be Empty !")
            gg.setVisible(true)
        else
            print("Added Expired Date : True")
            DATA = '\nif os.date("%Y%m%d") >= "' .. exp_date[1] .. '" then print("' .. exp_date[2] .. '") return gg.alert("' .. exp_date[2] .. '") end\n' .. DATA
        end
    end

    if g.info[6] == true then
        local PASS = gg.prompt({
            "Set Password For Script :",
            "Type Message For Wrong Password : "
        }, {
            "",
            "Wrong Password, Try Again!!!"
        }, {"text", "text"})

        if not PASS then
            gg.setVisible(true)
        elseif PASS[1] == nil then
            gg.alert("Input Password !")
            gg.setVisible(true)
        else
            print("Added Password Script : True")
            DATA = '\nlocal CXY = "' .. PASS[1] .. '"\n' ..
                   'PASSW = gg.prompt({"Input password: "}, {[1] = ""}, {[1] = "text"})\n' ..
                   'if not PASSW then print("' .. PASS[2] .. '") return end\n' ..
                   'if PASSW[1] == "" then gg.alert("Password Can Not Be Empty") os.exit(print("Password Can Not Be Empty")) end\n' ..
                   'if PASSW[1] ~= CXY then print("' .. PASS[2] .. '") return end\n' ..
                   'if PASSW[1] == CXY then gg.toast("Encryption By @ScolariOfficial") end\n' .. DATA
        end
    end

if g.info[7] == true then
    local VERSION = gg.prompt({
        "Set GG Version : ",
        "Set Error GG Message :"
    }, {
        gg.VERSION,
        "Error GG Version"
    }, {
        "number",
        "text"
    })

    if not VERSION then
        gg.setVisible(true)
    elseif VERSION[1] == nil then
        gg.alert("Input Required GG Version !")
        gg.setVisible(true)
    else
        print("GG Version Required : True✔")
        DATA = '\nlocal currentVersion = gg.VERSION\nif currentVersion ~= "' .. VERSION[1] .. '" then\n    print("' .. VERSION[2] .. '")\n    return gg.alert("' .. VERSION[2] .. '")\nend\n' .. DATA
    end
end

if g.info[8] == true then
    local original_name = g.last:match("[^/]+$"):gsub("%.lua$", "")
    
    local NAME = gg.prompt({
        "Set Name For Script :",
        "Type Message For Name Changed :",
    }, {
        original_name,
        "Rename Detected!!"
    }, {
        "text",
        "text"
    })

    if not NAME then
        gg.setVisible(true)
    elseif NAME[1] == nil or NAME[1] == "" then
        gg.alert("Set Name Can Not Be Empty !")
        gg.setVisible(true)
    else
        print("Added Rename Blocker : True✔")
        
        local final_name = NAME[1]:gsub("%.lua$", "")
        g.out = g.info[2] .. '/' .. final_name .. '.lua'
        
        local renameBlockerCode = [[
do
    local expected_name = "]] .. final_name .. [["
    local current_name = gg.getFile():match("[^/]+$"):gsub("%.lua$", "")
    if current_name ~= expected_name then
        local msg = "]] .. (NAME[2] or "Rename Detected") .. [[\n\nName must be: " .. expected_name .. ".lua"
        gg.alert(msg)
        os.exit()
    end
end
]]
        DATA = renameBlockerCode .. DATA
    end
end

if g.info[9] == true then
    local ScolariEncrypt = gg.prompt({
        "Set Your Package GameGuardian",
        "Type Message If Package Is Wrong :"
    }, {
        "com.GameGuardian.id",
        "Use My GG For Run This Script"
    }, {
        "text",
        "text"
    })

    if not ScolariEncrypt then
        gg.setVisible(true)
    elseif ScolariEncrypt[1] == nil then
        gg.alert("Set Package GameGuardian Can Not Be Empty!")
        gg.setVisible(true)
    else
        print("Set Package GG : True✔")
        
        local packageCheckCode = [[
do
    if gg.PACKAGE ~= "]] .. ScolariEncrypt[1] .. [[" then
        gg.alert("]] .. ScolariEncrypt[2] .. [[")
        print("]] .. ScolariEncrypt[2] .. [[")
        os.exit()
    end
end
]]
        DATA = packageCheckCode .. DATA
    end
end

if g.info[10] == true then
    local ScolariEncrypt = gg.prompt({
        "Set Package Game",
        "Type Message If Package Is Wrong :"
    }, {
        "com.xample.org",
        "Use Script In Game"
    }, {
        "text",
        "text"
    })

    if not ScolariEncrypt then
        gg.setVisible(true)
    elseif ScolariEncrypt[1] == nil then
        gg.alert("Set Package Game Can Not Be Empty!")
        gg.setVisible(true)
    else
        print("Set Package Game : True✔")
        
        local gamePackageCheckCode = [[
do
    local targetPackage = gg.getTargetInfo().processName
    if targetPackage ~= "]] .. ScolariEncrypt[1] .. [[" then
        gg.alert("]] .. ScolariEncrypt[2] .. [[")
        print("]] .. ScolariEncrypt[2] .. [[")
        os.exit()
    end
end
]]
        DATA = gamePackageCheckCode .. DATA
    end
end

    local header_text = "\n\n\n\n\n\n\n-------------------------------------------------\n  ENCRYPTION LUA V1\n-------------------------------------------------\n\nProtect Encrypt Lua V1\n\n* Big log - Anti hook\n* Crash sstool - Big lasm\n* Error lasm + Dump lasm\n* Memory Bomb\n* Timing Attack Detection\n* Detect SSTool\n* Integrity Check\n* Runtime Encryption\n\nPower by: \nTelegram @ScolariOfficial\nTelegram Channel @ScolariChannel\n\n-------------------------------------------------\n  ENCRYPTION LUA V1\n-------------------------------------------------\n\n\n\n\n\n\n"

    DATA = 'collectgarbage("collect")\n' ..
           'local _ = "' .. header_text:gsub('"', '\\"'):gsub("\n", "\\n") .. '"\n' ..
           'local function __()\n' ..
           '    local function Kimochi()\n' ..
           '        local B\n' ..
           '        ' .. big .. '\n' ..
           '    end\n' ..
           '    ' .. DATA .. '\n' ..
           'end\n' ..
           'local ___ = __()\n'

    DATA = string.dump(load(DATA), true)
    DATA = string.dump(load(DATA), true, true)
    DATA = gg.internal2(load(DATA), g.out)

    io.input(g.out, "r")
    DATA = io.read("*a")

    DATA = DATA:gsub('maxstacksize [^\n]*', 'maxstacksize 250')
    DATA = DATA:gsub('is_vararg [^\n]*', 'is_vararg 8')
    DATA = DATA:gsub("numparams [^\n]*", "numparams 250")
    DATA = DATA and DATA:gsub("linedefined [-]+(%d+)", "linedefined 163") or nil
    DATA = DATA and DATA:gsub("lastlinedefined [-]+(%d+)", "lastlinedefined 156") or nil

    DATA = string.dump(load(string.dump(load(DATA), true)), true)

    DATA = DATA:gsub(string.char(163, 0, 0, 0, 156, 0, 0, 0),
                     string.char(255, 255, 255, 255, 255, 255, 255, 255))
    DATA = DATA:gsub(string.char(0, 1, 4, 4, 4, 8, 0, 25, 147, 13, 10, 26, 10, 255, 255, 255, 255, 255, 255, 255, 255),
                     string.char(0, 1, 4, 4, 4, 8, 0, 25, 147, 13, 10, 26, 10, 240, 159, 135, 187, 240, 159, 135, 179))
    DATA = DATA:gsub(string.char(27, 76, 117, 97, 82, 0, 1, 4, 4, 4, 8, 0, 25, 147, 13, 10, 26, 10, 240, 159, 135, 174, 240, 159, 135, 169, 88, 240, 159, 135, 187, 240, 159, 135, 179, 88, 240, 159, 135, 184, 240, 159, 135, 190, 0, 1, 3, 5),
                     string.char(240, 159, 135, 187, 240, 159, 135, 179, 32, 73, 110, 100, 111, 110, 101, 115, 105, 97, 69, 110, 99, 114, 121, 112, 116, 32, 240, 159, 135, 174, 240, 159, 135, 169))
    DATA = DATA:gsub(string.char(0, 0, 0, 65, 0, 0, 0, 129, 64, 0, 0, 29, 64, 128, 1, 31, 0, 128, 0, 2, 0, 0, 0, 4),
                     string.char(0, 0, 0, 102, 0, 0, 1, 30, 0, 0, 0, 2, 0, 0, 0, 4))

    gg.toast("Done Encrypt !!!")

    local CUK = "MeXxMx"
    local BIG = string.char(0):rep(10000)
    DATA = DATA:gsub(string.char(4, 7, 0, 0, 0) .. CUK, string.char(4, 17, 39, 0, 0) .. BIG)

    gg.toast("Save File : " .. g.out .. "")
    print("Encrypt By @ScolariOfficial\n\nSave To: " .. g.out .. "")
    io.open(g.out, "w"):write(DATA):write("\n\n" .. header_text .. "\n")

    break
end