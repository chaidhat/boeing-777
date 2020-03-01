-- Panel_MCP.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

hdg = globalPropertyf("donut/panels/MCP/heading")
vv = 0
vo = 0
ho = 0
h = 0
frame = 0
alt = 0
alta = 0
fmcOn = false
f = 0
f1 = 0

outputVariables = true  -- display heading or not









--[[function Msg(str)

for i = 1, 11, 1 do
if frame % 5 == 0 then
if get(globalPropertys("donut/eicasmsg/" .. i)) == "" and get(globalPropertys("donut/eicasmsg/" .. i .. "/r")) == "" and get(globalPropertys("donut/eicasmsg/" .. i .. "/w")) == "" then
set(globalPropertys("donut/eicasmsg/" .. i), str)
end
if get(globalPropertys("donut/eicasmsg/" .. i)) == str then
break
end
end
end
end -- end Msg

function Msgr(str) -- Display red message

for i = 1, 11, 1 do
if frame % 5 == 0 then
if (not get(globalPropertys("donut/eicasmsg/" .. i))) == "" or (i > 7 and (not get(globalPropertys("donut/eicasmsg/" .. i .. "/w")) == "") or false) then

k = {}
l = {}

for j = i, 11, 1 do
k[j] = get(globalPropertys("donut/eicasmsg/" .. j)) or ""

if j < 7 then
l[j] = get(globalPropertys("donut/eicasmsg/" .. j .. "/w")) or ""
end
end

for j = i, 11, 1 do
set(globalPropertys("donut/eicasmsg/" .. j + 1), k[j])
set(globalPropertys("donut/eicasmsg/" .. j + 1 .. "/w"), l[j])
end

set(globalPropertys("donut/eicasmsg/" .. i .. "/r"), str)
break
end

if i == 11 then
for i = 1, 3, 1 do
if get(globalPropertys("donut/eicasmsg/" .. i .. "/r")) == "" then
set(globalPropertys("donut/eicasmsg/" .. i .. "/r"), str)
end
end
end

if get(globalPropertys("donut/eicasmsg/" .. i)) == str then
break
end -- end if
end
end
end -- end Msg

function ClearMsg(str)

for i = 1, 11, 1 do
if frame % 5 == 0 then
if get(globalPropertys("donut/eicasmsg/" .. i)) == str then
set(globalPropertys("donut/eicasmsg/" .. i), "")
break
end
end
end
end -- end Msg

function ClearMsgr(str)

for i = 1, 3, 1 do
if frame % 5 == 0 then
if get(globalPropertys("donut/eicasmsg/" .. i .. "/r")) == str then
set(globalPropertys("donut/eicasmsg/" .. i .. "/r"), "")
break
end
end
end
end -- end Msg --]]







function Msg(str, type) -- Sends message to _Main_EICAS,    type 1 = w, 2 (default) = y, 3 = r



type = type or 2

suffix = ((type == 1) and "/w") or ((type == 2) and "") or ((type == 3) and "/r")
print (get(globalPropertys("donut/eicasmsg/" .. 1 .. suffix)))

for i = 1, 11, 1 do
if frame % 5 == 0 then
if get(globalPropertys("donut/eicasmsg/" .. i .. suffix)) == "" then
set(globalPropertys("donut/eicasmsg/" .. i .. suffix), str)
end
if get(globalPropertys("donut/eicasmsg/" .. i .. suffix)) == str then
break
end
end
end
end -- end Msg

function ClearMsg(str, type) -- Clears message

function itob (input) -- int to boolean
if input == 0 then
return false
end
return true
end -- end int to boolean



type = type or 2

suffix = ((type == 1) and "/w") or ((type == 2) and "") or ((type == 3) and "/r")

for i = 1, 11, 1 do
if frame % 5 == 0 then
if get(globalPropertys("donut/eicasmsg/" .. i .. suffix)) == str then
set(globalPropertys("donut/eicasmsg/" .. i .. suffix), "")
break
end
end
end
end -- end Msg

function inttobyte (inp)
local out = {};
if inp then
for i = 6, 0, -1 do
if inp - math.pow(2, i - 1) >= 0 then
inp = inp - math.pow(2, i - 1); out[i] = true
end -- end if
end
end
return out
end -- end inttobyte










function update ()

if frame % 5 == 0 then
	x = 1
while x == 1 do -- allocates messages
	x = 0
	k = 1
	while (not (get(globalPropertys("donut/eicasmsg/" .. k + 1)) == "")) and k < 10 do -- allocates messages
		if (get(globalPropertys("donut/eicasmsg/" .. k)):sub (1,1) == " ") then
			if not (get(globalPropertys("donut/eicasmsg/" .. k + 1)):sub (1,1) == " ") then
				l = get(globalPropertys("donut/eicasmsg/" .. k + 1))
				set(globalPropertys("donut/eicasmsg/" .. k + 1), get(globalPropertys("donut/eicasmsg/" .. k)))
				set(globalPropertys("donut/eicasmsg/" .. k), l)
				x = 1
			end
		end
		k = k + 1
	end
end
end


frame = frame + 1
if get(globalPropertyf("sim/time/total_flight_time_sec")) < 11 then
    set (globalPropertyf("donut/copyrightmessage"), 1)
if get(globalPropertyf("sim/time/total_flight_time_sec")) > 10 then
set (globalPropertyf("donut/copyrightmessage"), 0)
end
end

--[[
if get(globalPropertyf("xfmc/Status")) then
fmcOn = get(globalPropertyf("xfmc/Status"))
end
]]--

get(globalPropertyf("donut/panels/MCP/iasmach"))
get(globalPropertyf("donut/panels/MCP/hdgtrk"))
get(globalPropertyf("donut/panels/MCP/vsfpa"))

ClearMsg("no autoland")
ClearMsg("ap disconnect", 3)
ClearMsg("speedbrake", 1)
ClearMsg("speedbrake eytended", 2)
ClearMsg("speedbrake armed", 1)
for i = 1, 5, 1 do
ClearMsg("autobrake " .. i, 1)
end
ClearMsg("autobrake rto", 1)
ClearMsg("pass signs on", 1)
ClearMsg("parking brake", 1)

if itob(get(globalPropertyi("sim/cockpit/warnings/annunciators/autopilot_disconnect"))) then
Msg("ap disconnect", 3)
end
if get(globalPropertyi("sim/cockpit/switches/auto_brake_settings")) > 1 then
Msg("autobrake " .. get(globalPropertyi("sim/cockpit/switches/auto_brake_settings")) - 1, 1)

end
if get(globalPropertyi("sim/cockpit/switches/auto_brake_settings")) == 0 then
Msg("autobrake rto", 1)

end

if itob(get(globalPropertyi("sim/cockpit/switches/fasten_seat_belts"))) then
Msg("pass signs on", 1)
end
if (get(globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 1)) > 44) and (get(globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 2)) > 44) then
	if itob(get(globalPropertyi("sim/cockpit/warnings/annunciators/speedbrake"))) then
	Msg("speedbrake eytended", 2)
	end
end
if get(globalPropertyf("sim/cockpit2/controls/speedbrake_ratio")) < 0 then
	Msg("speedbrake armed", 1)
	end
if get(globalPropertyf("sim/flightmodel/controls/parkbrake")) == 1 then
Msg("parking brake", 1)
end

if outputVariables then                                                 -- Update figures
if inttobyte(fmcOn)[2] then

else
--set (globalPropertyf("sim/cockpit/autopilot/heading"), math.floor(get(hdg)))

end

if inttobyte(fmcOn)[3] then
--set (globalPropertyf("sim/cockpit/autopilot/vertical_velocity"), (math.floor(get(globalPropertyf("donut/panels/MCP/vertical")) * 100)))

--set(globalPropertyf("sim/cockpit/autopilot/altitude"), get(globalPropertyf("sim/cockpit/autopilot/altitude")) + ((alt - 10) * 100 * math.pow(10, get(globalPropertyi("donut/panels/MCP/altitudexorm")))))
alta = get(globalPropertyf("sim/cockpit/autopilot/altitude"))
alt = 10


end

--set(globalPropertyi("xfmc/Keypath"), 16)
--print(get(globalPropertyi("xfmc/Keypath")))

if fmcOn then
if not inttobyte(fmcOn)[3] and not itob(get(globalPropertyi("donut/panels/MCP/vnav")))
 then
set(globalPropertyi("donut/panels/MCP/vnav"), 1)
end

if inttobyte(fmcOn)[3] and itob(get(globalPropertyi("donut/panels/MCP/vnav")))
then
set(globalPropertyi("donut/panels/MCP/vnav"), 0)
end

else
set(globalPropertyi("donut/panels/MCP/vnav"), 0)

end

if inttobyte(fmcOn)[2] and not itob(get(globalPropertyi("donut/panels/MCP/lnav")))
then
set(globalPropertyi("donut/panels/MCP/lnav"), 1)
end

if not inttobyte(fmcOn)[2] and itob(get(globalPropertyi("donut/panels/MCP/lnav")))
then
set(globalPropertyi("donut/panels/MCP/lnav"), 0)
end

set(globalPropertyi("donut/panels/MCP/vvis"), get(globalPropertyi("sim/cockpit2/autopilot/vvi_status")))
set(globalPropertyi("donut/panels/MCP/alts"), get(globalPropertyi("sim/cockpit2/autopilot/altitude_hold_status")))

set(globalPropertyf("donut/mcp/spd"), get(globalPropertyf("sim/cockpit/autopilot/airspeed"))
)

set(globalPropertyf("donut/mcp/hdg"), h)
set(globalPropertyf("donut/mcp/vv"), vv)
set(globalPropertyf("donut/mcp/alt"), get(globalPropertyf("sim/cockpit/autopilot/altitude")))
end








if (get(globalPropertyf("donut/panels/MCP/altitude")) == 10) then       -- Altitude
outputVariables = true
else
outputVariables = false
alt = math.floor(get(globalPropertyf("donut/panels/MCP/altitude")))
if inttobyte(fmcOn)[3] then
set(globalPropertyf("sim/cockpit/autopilot/altitude"), (math.floor((alta + alt + ((alt - 10) * 100 * math.pow(10, get(globalPropertyi("donut/panels/MCP/altitudexorm"))))) / 100) * 100))
set(globalPropertyf("donut/mcp/alt"), (math.floor((alta + alt + ((alt - 10) * 100 * math.pow(10, get(globalPropertyi("donut/panels/MCP/altitudexorm"))))) / 100) * 100))
end
end
set (globalPropertyf("donut/panels/MCP/altitude"), 10)

if get(globalPropertyf("donut/panels/MCP/apdisconnect")) == 1 then
Msg ("no autoland")
end

if not (get(hdg) == 180) then
	h = get(hdg) - 180 - ho
	h = math.abs(h) % 360
	print(get(hdg))
	f = frame
else
	ho = h
end
set (globalPropertyf("donut/panels/MCP/heading"), 180)   

if get(globalPropertyf("donut/panels/MCP/vsfpa")) == 0 then
	vv = math.floor(get(globalPropertyf("donut/panels/MCP/vertical"))) * 100 

else
	vv = ((math.floor(get(globalPropertyf("donut/panels/MCP/vertical"))) + 10) * 0.1342857143) - 9.9

end

if get(globalPropertyf("donut/panels/MCP/vsfpa")) == 0 then
	vv = math.floor(get(globalPropertyf("donut/panels/MCP/vertical"))) * 100 

else
	vv = ((math.floor(get(globalPropertyf("donut/panels/MCP/vertical"))) + 10) * 0.1342857143) - 9.9

end

if get(globalPropertyf("donut/panels/MCP/iasmach")) == 0 then
	vv = math.floor(get(globalPropertyf("donut/panels/MCP/vertical"))) * 100 

else
	vv = ((math.floor(get(globalPropertyf("donut/panels/MCP/vertical"))) + 10) * 0.1342857143) - 9.9

end
end
