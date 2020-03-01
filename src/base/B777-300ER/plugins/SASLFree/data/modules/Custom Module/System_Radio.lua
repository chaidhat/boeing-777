-- System_Radio.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0



radio1_mode = 1
hfsens1_mode = false
acp1_mode = 0

timer = {}
radios = {}
radioa = {}
for i = 1, 6, 1 do
radioa[i] = 110
radios[i] = 110
timer[i] = 0
end
hfsens = 75
com1 = 0
com2 = 0
frame = 0



function itob (input) -- int to boolean
if input == 0 then
return false
end
return true
end -- end int to boolean

function update ()

if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/toggle"))) then
if not hfsens1_mode then
set(globalPropertyf("donut/radio1a"), radioa[radio1_mode])              --For HF sensitivity, use a value less than one for A not S radio
set(globalPropertyf("donut/radio1s"), radios[radio1_mode])
else
set(globalPropertyf("donut/radio1a"), hfsens / 1000)              --For HF sensitivity, use a value less than one for A not S radio
set(globalPropertyf("donut/radio1s"), 0)
end

if not com1 == get(globalPropertyi("sim/cockpit/radios/com1_freq_hz")) then
radioa[1] = get(globalPropertyi("sim/cockpit/radios/com1_freq_hz") / 100)
end
if not com2 == get(globalPropertyi("sim/cockpit/radios/com2_freq_hz")) then
radioa[3] = get(globalPropertyi("sim/cockpit/radios/com2_freq_hz") / 100)
end



com1 = get(globalPropertyi("sim/cockpit/radios/com1_freq_hz"))
com2 = get(globalPropertyi("sim/cockpit/radios/com2_freq_hz"))
set(globalPropertyf("sim/cockpit/radios/com1_freq_hz"), math.floor(radioa[1] * 100))
set(globalPropertyf("sim/cockpit/radios/com1_freq_hz"), math.floor(radioa[3] * 100))

set(globalPropertyf("sim/cockpit/radios/com1_freq_hz"), radioa[3])

else
set(globalPropertyf("donut/radio1a"), 0)              --For HF sensitivity, use a value less than one for A not S radio
set(globalPropertyf("donut/radio1s"), 0)

end

set(globalPropertyf("donut/radio2a"), 1)
set(globalPropertyf("donut/radio2s"), 1)
set(globalPropertyf("donut/radio3a"), 1)
set(globalPropertyf("donut/radio3s"), 1)
set(globalPropertyf("donut/transponder"), 1)

radios[radio1_mode] = math.floor(get(globalPropertyf("donut/panels/pedestal/panel1/radioIn"))) + (math.floor(get(globalPropertyf("donut/panels/pedestal/panel1/radioOut")) / 1000 + 108))
if not get(globalPropertyf("donut/panels/pedestal/panel1/hfsens")) == hfsens then
hfsens1_mode = true
if frame % 5 == 0 then
timer[1] = get(globalPropertyf("sim/time/zulu_time_sec"))
end
end

if frame % 5 == 0 then
if get(globalPropertyf("sim/time/zulu_time_sec")) > timer[1] + 3 then
hfsens1_mode = false
end
end

hfsens = get(globalPropertyf("donut/panels/pedestal/panel1/hfsens"))

get(globalPropertyi("donut/panels/pedestal/panel1/radio/dual"))

if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/standby"))) then
radioa[radio1_mode] = radios[radio1_mode]
set(globalPropertyf("donut/panels/pedestal/panel1/radioIn"), radios[radio1_mode] - math.floor(radios[radio1_mode]))
set(globalPropertyf("donut/panels/pedestal/panel1/radioOut"), radios[radio1_mode])
end

if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/lvhf"))) then
radio1_mode = 1

set(globalPropertyf("donut/panels/pedestal/panel1/radioIn"), radios[radio1_mode] - math.floor(radios[radio1_mode]))
set(globalPropertyf("donut/panels/pedestal/panel1/radioOut"), radios[radio1_mode])
end
if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/cvhf"))) then
radio1_mode = 2

set(globalPropertyf("donut/panels/pedestal/panel1/radioIn"), radios[radio1_mode] - math.floor(radios[radio1_mode]))
set(globalPropertyf("donut/panels/pedestal/panel1/radioOut"), radios[radio1_mode])
end
if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/rvhf"))) then
radio1_mode = 3

set(globalPropertyf("donut/panels/pedestal/panel1/radioIn"), radios[radio1_mode] - math.floor(radios[radio1_mode]))
set(globalPropertyf("donut/panels/pedestal/panel1/radioOut"), radios[radio1_mode])
end
if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/lhf"))) then
radio1_mode = 4

set(globalPropertyf("donut/panels/pedestal/panel1/radioIn"), radios[radio1_mode] - math.floor(radios[radio1_mode]))
set(globalPropertyf("donut/panels/pedestal/panel1/radioOut"), radios[radio1_mode])
end
if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/rhf"))) then
radio1_mode = 5

set(globalPropertyf("donut/panels/pedestal/panel1/radioIn"), radios[radio1_mode] - math.floor(radios[radio1_mode]))
set(globalPropertyf("donut/panels/pedestal/panel1/radioOut"), radios[radio1_mode])
end
if itob(get(globalPropertyi("donut/panels/pedestal/panel1/radio/am"))) then
radio1_mode = 6

set(globalPropertyf("donut/panels/pedestal/panel1/radioIn"), radios[radio1_mode] - math.floor(radios[radio1_mode]))
set(globalPropertyf("donut/panels/pedestal/panel1/radioOut"), radios[radio1_mode])
end

set(globalPropertyi("donut/panels/pedestal/panel1/radio/lvhf"), 0)
set(globalPropertyi("donut/panels/pedestal/panel1/radio/cvhf"), 0)
set(globalPropertyi("donut/panels/pedestal/panel1/radio/rvhf"), 0)
set(globalPropertyi("donut/panels/pedestal/panel1/radio/lhf"), 0)
set(globalPropertyi("donut/panels/pedestal/panel1/radio/rhf"), 0)
set(globalPropertyi("donut/panels/pedestal/panel1/radio/am"), 0)

frame = frame + 1



end -- end update

