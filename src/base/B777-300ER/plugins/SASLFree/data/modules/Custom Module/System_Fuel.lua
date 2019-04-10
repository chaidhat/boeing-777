-- System_Fuel.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0




function itob (input) -- int to boolean
if input == 0 then
return false
end
return true
end -- end int to boolean

function update ()

fwdcrossfeed = itob(get(globalPropertyf("donut/panels/overhead/fuel/fwdcrossfeed")))
aftcrossfeed = itob(get(globalPropertyf("donut/panels/overhead/fuel/aftcrossfeed")))

set(globalPropertyf("donut/fuel/qtyl"), get(globalPropertyfae("sim/cockpit2/fuel/fuel_quantity", 2)) * 2.221 / 1000)
set(globalPropertyf("donut/fuel/qtyc"), get(globalPropertyfae("sim/cockpit2/fuel/fuel_quantity", 1)) * 2.221 / 1000)
set(globalPropertyf("donut/fuel/qtyr"), get(globalPropertyfae("sim/cockpit2/fuel/fuel_quantity", 3)) * 2.221 / 1000)

--	c "donut/fuel/qtyl"
--c "donut/fuel/qtyc"
--c "donut/fuel/qtyr"

lfwdpump = itob(get(globalPropertyf("donut/panels/overhead/fuel/lfwdpump")))
laftpump = itob(get(globalPropertyf("donut/panels/overhead/fuel/laftpump")))

rfwdpump = itob(get(globalPropertyf("donut/panels/overhead/fuel/rfwdpump")))
raftpump = itob(get(globalPropertyf("donut/panels/overhead/fuel/raftpump")))

lcentrepump = itob(get(globalPropertyf("donut/panels/overhead/fuel/lcentrepump")))
rcentrepump = itob(get(globalPropertyf("donut/panels/overhead/fuel/rcentrepump")))

fwdcrossfeed = aftcrossfeed or fwdcrossfeed -- is any of the buttons on?
lfwdpump = laftpump or lfwdpump
rfwdpump = raftpump or rfwdpump
lcentrepump = rcentrepump or lcentrepump

select = 4


if fwdcrossfeed then
tanklQty = get(globalPropertyfae("sim/cockpit2/fuel/fuel_quantity", 2))
tankrQty = get(globalPropertyfae("sim/cockpit2/fuel/fuel_quantity", 3))

if math.abs((tanklQty - tankrQty)) < 100 then
select = 4
else
select = ((tanklQty > tankrQty) and 3) or 1
end -- end if

end -- end if

set(globalPropertyi("sim/cockpit/engine/fuel_tank_selector"), select)
set(globalPropertyiae("sim/cockpit2/fuel/fuel_tank_pump_on", 1), lcentrepump and 1 or 0)
set(globalPropertyiae("sim/cockpit2/fuel/fuel_tank_pump_on", 2), lfwdpump and 1 or 0)
set(globalPropertyiae("sim/cockpit2/fuel/fuel_tank_pump_on", 3), rfwdpump and 1 or 0)
end -- end update

