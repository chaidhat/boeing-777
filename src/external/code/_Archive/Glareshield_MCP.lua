-- Glareshield_MCP.lua --
-- Chai11 Boeing 777-00ER     1-06-018

-- Script Version   0.0.1
-- Aircraft Version 0.40.0

defineProperty("spd", globalPropertyf("donut/panels/MCP/heading"))
defineProperty("a_spd", globalPropertyf("sim/cockpit/autopilot/heading"))
rpt_spd = 0
res_spd = true

function update ()
if res_spd then
set (globalPropertyf("sim/cockpit/autopilot/heading"), math.floor(get(spd)) + (rpt_spd * 20))

set (globalPropertyf("sim/cockpit/autopilot/vertical_velocity"), (math.floor(get(globalPropertyf("donut/panels/MCP/vertical")) * 100)))

set (globalPropertyf("sim/cockpit/autopilot/altitude"), (math.floor(get(globalPropertyf("donut/panels/MCP/altitude"))) * 10 * math.pow(10, get(globalPropertyi("donut/panels/MCP/altitudexorm")))) + 2000)
end

if get(spd) == -1 then
set (globalPropertyf("donut/panels/MCP/heading"), 359.9999)
rpt_spd = rpt_spd + 1
res_spd = true
end

if get(spd) == 360 then
set (globalPropertyf("donut/panels/MCP/heading"), 0.00001)
rpt_spd = rpt_spd - 1
res_spd = true
end

    if get(spd) == 20 then
        set (globalPropertyf("donut/panels/MCP/heading"), -1)
        res_spd = false
    end

    if get(spd) == 0 then
        set (globalPropertyf("donut/panels/MCP/heading"), 360)
        res_spd = false
    end
end
