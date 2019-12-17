-- System_Engine.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

lstart = true
rstart = true

lon = 0
ron = 0

lcusn1 = 0
rcusn1 = 0

frame = 0

function fcs_l_on (phase)
	if phase == SASL_COMMAND_END then
    	print "fcs_l_on"
	end
end --end fcs_l_on

function fcs_l_cutoff (phase)
    if phase == SASL_COMMAND_END then
    	print "fcs_l_cutoff"
	end
end --end fcs_l_cutoff





function itob (input) -- int to boolean
if input == 0 then
return false
end
return true
end -- end int to boolean

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
--]]

--donut/throttle_quad/fuel_control_switch_l_cutoff
lr = sasl.createCommand("donut/throttle_quad/fuel_control_switch_l_run", "")
rr = sasl.createCommand("donut/throttle_quad/fuel_control_switch_r_run", "")
lc = sasl.createCommand("donut/throttle_quad/fuel_control_switch_l_cutoff", "")
lr = sasl.createCommand("donut/throttle_quad/fuel_control_switch_r_cutoff", "")
sasl.registerCommandHandler(lr , 0, fcs_l_on)
sasl.registerCommandHandler(lc , 0, fcs_l_cutoff)

function update ()


frame = frame + 1

lstarter = itob(get(globalPropertyf("donut/panel/start1")))
rstarter = itob(get(globalPropertyf("donut/panel/start2")))
lfuel = itob(get(globalPropertyf("donut/panel/fuel1")))
rfuel = itob(get(globalPropertyf("donut/panel/fuel2")))

lcusn1 = get(globalPropertyf("donut/eicas/customn1"))
rcusn1 = get(globalPropertyf("donut/eicas/customn11"))

lcusegt = get(globalPropertyf("donut/eicas/customegt"))
rcusegt = get(globalPropertyf("donut/eicas/customegt1"))

set(globalPropertyf("donut/eng/vibl"), get(globalPropertyfae("sim/flightmodel/engine/ENGN_N2_", 1)) * 0.02)
set(globalPropertyf("donut/eng/vibr"), get(globalPropertyfae("sim/flightmodel/engine/ENGN_N2_", 2)) * 0.02)

ln2 = get(globalPropertyfae("sim/flightmodel/engine/ENGN_N2_", 1))
rn2 = get(globalPropertyfae("sim/flightmodel/engine/ENGN_N2_", 2))

legt = get(globalPropertyfae("sim/flightmodel/engine/ENGN_EGT_c", 1))
regt = get(globalPropertyfae("sim/flightmodel/engine/ENGN_EGT_c", 2))

ln1 = get(globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 1))
rn1 = get(globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 2))

-- Cannot be >= or else divide by zero
if ln1 > 33 then
    lcusn1 = (79 * ((ln1 - 33) / 67)) + 21;
    
else
    lcusn1 = 21 * (ln1 / 33);
end

if rn1 > 33 then
rcusn1 = (79 * ((rn1 - 33) / 67)) + 21;

else
rcusn1 = 21 * (rn1 / 33);
end

if lstarter then
    if not lstart then
        if lfuel then
        sasl.commandBegin(sasl.findCommand("sim/starters/engage_starter_1")); lstart = true
        end
    end
    if lfuel then
        if ln2 > 32 then
lon = 0.5
        else
lon = 0.7
        end
        if ln2 > 63 then
set(globalPropertyf("donut/panel/start1"), 0)
        end
    else
lon = 0
    end
else
    if lfuel then
        if not lon == 0.99 then
lon = 1
        end
    else
lon = 0
    end
    if lstart then
sasl.commandEnd(sasl.findCommand("sim/starters/engage_starter_1")); lstart = false; lon = 0.99
    end
end -- end if



    if lon == 0 then
set(globalPropertyf("donut/eicas/customegt"), legt)
    end
    if lon == 1 then
set(globalPropertyf("donut/eicas/customegt"), legt)
    end
    if lon == 0.5 then
set(globalPropertyf("donut/eicas/customegt"), 470 * ((ln2 - 32) / 31) + 50)
    end

    if lon == 0.7 then
set(globalPropertyf("donut/eicas/customegt"), 40 * (ln2 / 32) + 10)
    end

    if lon == 0.99 then
if lcusegt > legt then
set(globalPropertyf("donut/eicas/customegt"), lcusegt - 0.5)
else
lon = 1
set(globalPropertyf("donut/eicas/customegt"), legt)
end
    end



if rstarter then
if not rstart then
if rfuel then
sasl.commandBegin(sasl.findCommand("sim/starters/engage_starter_2")); rstart = true
end
end
if rfuel then
if rn2 > 32 then
ron = 0.5
else
ron = 0.7
end
if rn2 > 63 then
set(globalPropertyf("donut/panel/start2"), 0)
end
else
ron = 0
end
else
if rfuel then
if not ron == 0.99 then
ron = 1
end
else
ron = 0
end
if rstart then
sasl.commandEnd(sasl.findCommand("sim/starters/engage_starter_2")); rstart = false; ron = 0.99
end
end -- end if



if ron == 0 then
set(globalPropertyf("donut/eicas/customegt1"), regt)
end
if ron == 1 then
set(globalPropertyf("donut/eicas/customegt1"), regt)
end
if ron == 0.5 then
set(globalPropertyf("donut/eicas/customegt1"), 470 * ((rn2 - 32) / 31) + 50)
end

if ron == 0.7 then
set(globalPropertyf("donut/eicas/customegt1"), 40 * (rn2 / 32) + 10)
end

if ron == 0.99 then
if rcusegt > regt then
set(globalPropertyf("donut/eicas/customegt1"), rcusegt - 0.5)
else
ron = 1
set(globalPropertyf("donut/eicas/customegt1"), regt)
end
end

ClearMsg ("eng fail l+r")
ClearMsg ("eng fail l")
ClearMsg ("eng fail r")
ClearMsg ("eng fail l+r", 3)
ClearMsg ("eng fail l", 3)
ClearMsg ("eng fail r", 3)

x = get(globalPropertyf("xfmc/airbus/V1")) or 100
if get(globalPropertyf("sim/flightmodel/position/indicated_airspeed")) < get(x) - 6 then
if ln1 < 20 and lfuel and (not lstart) and rn1 < 20 and rfuel and (not rstart) then
Msg ("eng fail l+r", 3)
end
if ln1 < 20 and lfuel and (not lstart) and (not (rn1 < 20 and rfuel and (not rstart))) then
Msg ("eng fail l", 3)
end
if rn1 < 20 and rfuel and (not rstart) and (not (ln1 < 20 and lfuel and (not lstart))) then
Msg ("eng fail r", 3)
end
else
    if ln1 < 20 and lfuel and (not lstart) and rn1 < 20 and rfuel and (not rstart) then
Msg ("eng fail l+r")
end
if ln1 < 20 and lfuel and (not lstart) and (not (rn1 < 20 and rfuel and (not rstart))) then
Msg ("eng fail l")
end
if rn1 < 20 and rfuel and (not rstart) and (not (ln1 < 20 and lfuel and (not lstart))) then
Msg ("eng fail r")
end
end



set(globalPropertyfae("sim/cockpit2/engine/actuators/mixture_ratio", 1), lon)
set(globalPropertyfae("sim/cockpit2/engine/actuators/mixture_ratio", 2), ron)

set(globalPropertyf("donut/eicas/customn1"), lcusn1)
set(globalPropertyf("donut/eicas/customn11"), rcusn1)
end -- end update

