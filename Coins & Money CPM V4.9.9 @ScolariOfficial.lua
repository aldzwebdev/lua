
-- FUNCTION 
local _cp = "DefaultMessage"

function searchModule(_cq, _cr, _cs, _ct)
    gg.setVisible(false)
    gg.clearResults()
    _cs = _cs or 32
    if _cs == "A" then
        _cs = 32
    elseif _cs == "Xa" then
        _cs = 16384
    end
    _cp = _ct or _cp
    gg.setRanges(tonumber(_cs))
    gg.searchNumber(_cq, _cr)
    local _cu = gg.getResults(100000)
    if #_cu == 0 then
        gg.clearResults()
        gg.alert("\nCode error:\nО_O_Parking_v1.lua/" .. _cp .. ":\nNo Results found (Not Found: Results[1])\nコードが見つかりませんでした\n\nしばらくしてからもう一度お試しください")
        return nil
    end
    return _cu
end

function getResults(_cz, _da, _db)
    local _dc = {}
    for i, r in ipairs(_cz) do
        for j, off in ipairs(_da) do
            if not _dc[j] then
                _dc[j] = {}
            end
            table.insert(_dc[j], {
                address = r.address + off,
                flags = _db[j] or 32,
            })
        end
    end
    return _dc
end

function filterResults(_dd, _de)
    local _df = {}
    local _dg = {}
    for i, rs in ipairs(_dd) do
        _df[i] = gg.getValues(rs)
    end
    for i = 1, #_df[1] do
        local _dh = true
        for j, condition in ipairs(_de) do
            local _di = _df[j][i].value
            if condition.key1 then
                if _di ~= condition.key1[1] then
                    _dh = false
                    break
                end
            elseif condition.key2 then
                if (condition.key2.min and _di < condition.key2.min) or (condition.key2.max and _di > condition.key2.max) then
                    _dh = false
                    break
                end
            elseif condition.key3 then
                local _dj = false
                for _, v in ipairs(condition.key3) do
                    if _di == v then
                        _dj = true
                        break
                    end
                end
                if not _dj then
                    _dh = false
                    break
                end
            end
        end
        if _dh then
            table.insert(_dg, _df[1][i])
        end
    end
    if #_dg == 0 then
        gg.clearResults()
        gg.alert("\nCode error:\nО_O_Parking_v1.lua/" .. _cp .. ":\nNo Results found (Not Found: Results[2])\nコードが見つかりませんでした\n\nしばらくしてから修正をお試しください")
        return 
    end
    return _dg
end
on = true
function setvalue(_p, _q, _r)
    local _s = {
        address = _p,
        flags = _q,
        value = _r,
        freeze = true,
    }
    gg.addListItems({
        _s,
    })
    gg.removeListItems({
        _s,
    })
end
function v_setValues(_dk, _dl, _dm, _dn)
    local _do = {}
    for _, v in ipairs(_dk) do
        if not v.address then
            gg.clearResults()
            gg.alert("Error: address is nil")
            return 
        end
    end
    for idx, v in ipairs(_dk) do
        for i, off in ipairs(_dl) do
            local _dp = (idx - 1) * #_dl + i
            _do[_dp] = {
                address = v.address + off,
                flags = _dm[i] or _dm[1],
                value = _dn[i] or _dn[1],
                freeze = true,
            }
        end
    end
    MemoryList(_do)
    gg.setVisible(false)
    gg.clearResults()
end

function MemoryList(_dq)
    gg.addListItems(_dq)
    gg.removeListItems(_dq)
end

function SecreDevPatch(_dr, _ds)
    if #_dr < 1 then
        return false
    end
    if libs == nil then
        local _dt = gg.getRangesList('libil2cpp.so')
        if _dt and _dt[2] then
            libs = _dt[2].start
        end
    end
    if libs == nil then
        gg.alert("libs (libil2cpp.so) not found - cannot patch")
        return false
    end
    local _du = {}
    for _, patch in ipairs(_dr) do
        table.insert(_du, {
            address = libs + _ds + patch[1],
            value = patch[2],
            flags = patch[3] or gg.TYPE_DWORD,
            freeze = true,
        })
    end
    gg.setRanges(gg.REGION_CODE_APP)
    gg.addListItems(_du)
    gg.removeListItems(_du)
end

function clearReset()
    gg.setVisible(false)
    gg.clearResults()
    gg.clearList()
end

function main()
 menu = gg.choice({
   "Coins Menu",--1
   "Money Menu",--2
   "Unlock Menu",--3
   "Other Menu",--4
   "Exit"--5
   },nil,"Script developers : ScolariOfficial\nYT: @ScolariOfficial\nTelegram: @ScolariOfficial\n"..os.date('\nToday : %d %B %Y\nTime : %X %p\n'))

if menu == 1 then Coins() end
if menu == 2 then Money() end
if menu == 3 then Unlock() end
if menu == 4 then Other() end
if menu == 5 then Exit() end
end

-- Coins Menu
function Coins() 
menu1 = gg.choice({
    "Instan Coins Custom",
    "Back Menu",
   },nil,"Coins Menu")
   if menu1 == nil then
    Coins()
   else
    if menu1 == 1 then setCoins() end
    if menu1 == 2 then main() end
  end
end

-- setCoins
function setCoins()
   libs = gg.getRangesList('libil2cpp.so')[2].start
    function patch(nv, fs)
        if #nv < 1 then
            return false
        end
        local ft = {
        }
        for _, patch in ipairs(nv) do
            table.insert(ft, {
                address = libs + fs + patch[1],
                value = patch[2],
                flags = patch[3] or gg.TYPE_DWORD,
                freeze = true,
            })
        end
        gg.setRanges(gg.REGION_CODE_APP)
        gg.addListItems(ft)
        gg.removeListItems(ft)
    end
    local nov = gg.prompt({
        "Coin Amount",
        "Freeze",
        "Cancel",
    }, {
        "30000",
        false,
        false,
    }, {
        "number",
        "checkbox",
        "checkbox",
    })
    if not nov then
        gg.toast("Canceled")
        return 
    end
    local amount = tonumber(nov[1])
    local freeze = nov[2]
    local cancel = nov[3]
    if cancel then
        gg.toast("Canceled By User")
        return 
    end
    local fy = 53097904
    local fz = 53098232
    local ga = 53098880
    local gb = {
        {
            0,
            1.65488266e-24,
            gg.TYPE_FLOAT,
        },
    }
    patch(gb, fy)
    local gc = {
        {
            0,
            amount,
            gg.TYPE_DWORD,
        },
    }
    patch(gc, fz)
    local gd = {
        {
            0,
            1.41234084e-13,
            gg.TYPE_FLOAT,
        },
    }
    patch(gd, ga)
    if freeze then
        gg.addListItems({
            {
                address = libs + fz,
                flags = gg.TYPE_DWORD,
                value = amount,
                freeze = true,
            },
        })
    end
   gg.alert("Enter easy park level and return to lobby")
   gg.toast("Succes Set Coin : " .. amount)
end

-- Money Menu
function Money() 
menu2 = gg.choice({
    "Instan Money Custom",
    "Back Menu",
   },nil,"Money Menu")
   if menu2 == nil then
    Money()
   else
    if menu2 == 1 then setMoney() end
    if menu2 == 2 then main() end
  end
end

-- setMoney
function setMoney()
    local gr = gg.getRangesList('libil2cpp.so')[2].start
    function patch(gh, gi)
        if #gh < 1 then
            return false
        end
        local gj = {
        }
        for _, patch in ipairs(gh) do
            table.insert(gj, {
                address = gr + gi + patch[1],
                value = patch[2],
                flags = patch[3] or gg.TYPE_FLOAT,
            })
        end
        gg.setValues(gj)
    end
    local gk = gg.prompt({
        "Money Amount",
        "Cancel",
    }, {
        "50000000",
        false,
    }, {
        "number",
        "checkbox",
    })
    if not gk then
        gg.toast("Cancelled")
        return 
    end
    local amount = tonumber(gk[1])
    local cancel = gk[2]
    if cancel then
        gg.toast("Canceled By User")
        return 
    end
    local gn = 53193700
    local go = 53193404
    local gp = {
        {
            0,
            1.69382679e-21,
            gg.TYPE_FLOAT,
        },
    }
    patch(gp, gn)
    local gq = {
        {
            0,
            amount,
            gg.TYPE_FLOAT,
        },
    }
    patch(gq, go)
    gg.alert("Click on money")
    gg.toast("Succes Set Money : " .. amount)
end

function Unlock() 
menu3 = gg.choice({
    "Unlock Police Siren",
    "Unlock W16",
    "Unlock Toyota Crown",
    "Unlock All Exclusive Clothes",
    "Back Menu",
   },nil,"Unlock Menu")
   if menu3 == nil then
    Unlock()
   else
    if menu3 == 1 then UnPolice() end
    if menu3 == 2 then UnW16() end
    if menu3 == 3 then UnClothes() end
    if menu3 == 4 then main() end
  end
end

-- Unlock Police Siren 
function UnPolice()
    gg.alert("For this to work run it twice!")
    local gw = gg.getRangesList("libil2cpp.so")[2].start
    gg.setValues({
        [1] = {
            address = gw + 63478948,
            flags = gg.TYPE_DWORD,
            value = '~A8 MOV W0, #1',
        },
        [2] = {
            address = gw + 63478952,
            flags = gg.TYPE_DWORD,
            value = '~A8 RET',
        },
    })
    gg.toast("Succes Unlock Police Siren")
end

-- Unlock W16
function UnW16()
    local gs = gg.getRangesList("libil2cpp.so")[2].start
    gg.setValues({
        [1] = {
            address = gs + 52402720,
            flags = gg.TYPE_DWORD,
            value = '~A8 MOV	 W1, X0',
        },
    })
    gg.toast("Succes Unlock W16")
end

-- Unlock Clothes 
function UnClothes()
    local gt = 52140656
    local gu = 52135240
    local gv = 52141116
    SecreDevPatch({
        { 0, "~A8 MOV  W0, WZR" },
        { 4, "~A8 RET" },
    }, gv)
    SecreDevPatch({
        { 0, "~A8 MOV  W0, WZR" },
        { 4, "~A8 RET" },
    }, gu)
    SecreDevPatch({
        { 0, "~A8 MOV  W0, WZR" },
        { 4, "~A8 RET" },
    }, gt)
    gg.toast("Succes Unlock All Exclusive Clothes")
end

-- Other Menu
function Other() 
menu4 = gg.choice({
    "Change ID",
    "Log Name",
    "Back Menu",
   },nil,"Other Menu")
   if menu4 == nil then
    Other()
   else
    if menu4 == 1 then changeID() end
    if menu4 == 2 then LogName() end
    if menu4 == 3 then main() end
  end
end

-- Change ID
function changeID() 
change = gg.choice({
    "Change ID ( Random Generate )",
    "Change ID ( Custom )",
    "Back Menu",
   },nil,"Change ID")
   if change == nil then
    changeID()
   else
    if change == 1 then changeID1() end
    if change == 2 then changeID2() end
    if change == 3 then main() end
  end
end

function changeID1()
    clearReset()
    ofst = 57406056
    setvalue(libil2cpp + ofst, 16, -274877907000.0)
    ofst = 57406060
    setvalue(libil2cpp + ofst, 16, -61301799800000.0)
    gg.alert("LOG OUT OF YOUR ACCOUNT AND LOGIN AGAIN IN THIS CLICK GG LOGO")
    gg.setVisible(false)
    
    while true do
        if gg.isVisible() then
            break
        else
            gg.sleep(50)
        end
    end
    
    gg.setVisible(false)
    clearReset()
    ofst = 57406056
    setvalue(libil2cpp + ofst, 16, -1.27424214e+34)
    ofst = 57406060
    setvalue(libil2cpp + ofst, 16, -2.8720048e-14)
    gg.alert("CLICK EVIL 1 THE FACE")
    gg.toast("ON")
    clearReset()
end

function changeID2()
    local pw = gg.getRangesList("libil2cpp.so")[2].start
    gg.setVisible(false)
    ofst = 59740500
    setvalue(pw + ofst, 4, "~A8 MOV X20, X1")
    gg.alert("PUT A NEW NAME (THIS WILL BE YOUR ID) LOG OUT YOUR ACCOUNT AND LOGIN AGAIN")
    gg.toast("ON")
end

-- Log Name
function LogName()
    gg.setVisible(false)
    clearReset()
    local _px = searchModule("\x34\053\x33\x39\x36\x32\x38\052\050\x35\052\x35\x31\x34\x35\x37\x37\x34\x31", 32, "\x41", "\x4c\x6f\110\103\078\x61\x6d\101")
    if not _px then
        return 
    end
    local _py = {
        -60,
    }
    local _pz = {
        4,
    }
    local _qa = {
        {
            key2 = {
                min = 12,
                max = 100,
            },
        },
    }
    local _qb = getResults(_px, _py, _pz)
    local _qc = filterResults(_qb, _qa)
    local _qd = {
        0,
    }
    local _qe = {
        4,
    }
    local _qf = {
        99999,
    }
    if _qc then
        v_setValues(_qc, _qd, _qe, _qf)
    end
    gg.alert("NOW YOU CAN PUT A LONG NAME")
    gg.toast("SUCCES LOG NAME")
    clearReset()
end


function Exit()
   print("==============================")
   print("")
   print("Script By : @ScolariOfficial")
   print("　　　　⢀⣤⣶⣶⣖⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀")
   print("　　　⢀⣾⡟⣉⣽⣿⢿⡿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀") 
   print("　　⢠⣿⣿⣿⡗⠋⠙⡿⣷⢌⣿⣿⠀⠀⠀⠀⠀⠀⠀")
   print("⣷⣄⣀⣿⣿⣿⣿⣷⣦⣤⣾⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀") 
   print("⠈⠙⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⢀⠀⠀⠀⠀") 
   print("　　⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠻⠿⠿⠋⠀⠀⠀⠀") 
   print("　　　⠹⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀") 
   print("　　　　⠈⢿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⡄") 
   print("　　　　　⠙⢿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⢀⡾⠀") 
   print("　　　　　　⠈⠻⣿⣿⣿⣿⣷⣶⣴⣾⠏⠀⠀") 
   print("　　　　　　　　⠈⠉⠛⠛⠛⠋⠁⠀⠀⠀ ") 
   print("")
   print("")
  gg.clearResults()
  os.exit()
  end


if menu == nil then
menu = - 1
gg.clearResults()
end

while(true) do
if gg.isVisible(true) then
menu = 1
gg.setVisible(false)
end

if menu == 1 then main()
end end