-- aDatarefs.lua --
-- Chai11 Boeing 777-00ER     1-06-018

-- Script Version   0.0.1
-- Aircraft Version 0.40.0




local f_init = true -- is this the first update?
local a = 0

function update ()

    if f_init then

c "donut/a"
c "donut/m"


c "donut/custom/alt";
c "donut/eicas/white";          --How many white are displayed on eicas
c "donut/panel/cross";          --Fuel crossfeed button out
c "donut/panel/start1";         --Starter 1
c "donut/panel/start2";          --Starter 2
c "donut/panel/fuel1";          --Fuel switch 1
c "donut/panel/fuel2";           --Fuel switch 2
c "donut/panel/gear";           --Gear Lever
c "donut/eicas/customegt";      --Custom EGT for startup
c "donut/eicas/customegt1";     --Custom EGT for startup
c "donut/eicas/customn1";       --Custom N1 for startup
c "donut/eicas/customn11";      --Custom N1 for startup
c "donut/panel/bleedL";         --Bleed air
c "donut/panel/bleedR";         --Bleed air
c "donut/panel/bleedAPU";       --Bleed air
c "donut/panel/hydLPRI";        --primary hydraulics
c "donut/panel/hydC1PRI";       --primary hydraulics
c "donut/panel/hydC2PRI";        --primary hydraulics
c "donut/panel/hydRPRI";        --primary hydraulics
c "donut/panel/hydLDEM";        --demand hydraulics
c "donut/panel/hydC1DEM";       --demand hydraulics
c "donut/panel/hydC2DEM";        --demand hydraulics
c "donut/panel/hydRDEM";        --demand hydraulics
c "donut/panel/ExtpwrPRI";      --primary external power
c "donut/panel/ExtpwrSEC";      --secondary external power
c "donut/panel/beacon";         --secondary external power
c "donut/pfd/aoa";              --angle of attack
c "donut/pfd/fup";              --flaps up bug
c "donut/pfd/f1";               --flaps 1
c "donut/pfd/f5";               --flaps 5
c "donut/pfd/f15";              --flaps 15
c "donut/pfd/v1";               --v1 bug
c "donut/pfd/vr";               --vr
c "donut/pfd/v2";               --v2
c "donut/pfd/apprfl";           --FMC approach flaps
c "donut/pfd/apprsp";           --FMC approach speed
c "donut/pfd/altro";            --for altitude rolling tickmarks (altitude / 10)

    f_init = false -- the following update is no longer the first update

    end -- end if
end -- end update

function c(name) -- creates dataref

    defineProperty("x" .. a, createGlobalPropertyf(name, 1.0, false, true))
    a = a + 1

end -- end c
