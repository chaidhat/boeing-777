-- System_Bleed.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

m = 0
frame = 0




function itob (input) -- int to boolean
if input == 0 then
return false
end
return true
end -- end int to boolean

function update ()

frame = frame + 1

lbleed = itob(get(globalPropertyf("donut/panel/bleedL")))
rbleed = itob(get(globalPropertyf("donut/panel/bleedR")))
apubleed = itob(get(globalPropertyf("donut/panel/bleedAPU")))

if apubleed then
    if get(globalPropertyi("sim/cockpit/engine/APU_switch")) == 1 then -- changed to switch
        m = 4
    end
end

if rbleed then
        if lbleed then
        m = 2;

    else
        m = 3;

    end
else
    if lbleed then
        m = 1;

    else
        m = 0;

    end
end


set(globalPropertyi("sim/cockpit/pressure/bleed_air_mode"), m)
end -- end update

