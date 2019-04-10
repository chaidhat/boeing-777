-- _Main_Datarefs.lua --
-- Chai11 Boeing 777-00ER     1-06-018

-- Script Version   0.0.1
-- Aircraft Version 0.40.0

local a = 0
local alphabet = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "wa","wb","wc","wd","we","wf","wg","ra", "rb", "rc"}

function c(name) -- creates dataref

defineProperty("x" .. a, createGlobalPropertyf(name, 1.0, false, true))
a = a + 1

end -- end c

function ci(name) -- creates dataref as int

defineProperty("x" .. a, createGlobalPropertyi(name, 1.0, false, true))
a = a + 1

end -- end ci

function ca(name, length) -- creates an array for similar variables

for i = 0, length, 1 do
    c (name .. i)

end -- end for
end -- end ca

function cs(name) -- creates string dataref

defineProperty("x" .. a, createGlobalPropertys(name, "", false, true))
a = a + 1

end -- end cs

for i = 1, 11, 1 do -- defines EICAS datarefs (189)

c ("donut/eicas/" .. alphabet[i] .. "/a")
c ("donut/eicas/" .. alphabet[i] .. "/b")
c ("donut/eicas/" .. alphabet[i] .. "/c")
c ("donut/eicas2/" .. alphabet[i] .. "/a")
c ("donut/eicas2/" .. alphabet[i] .. "/b")
c ("donut/eicas2/" .. alphabet[i] .. "/c")
c ("donut/eicas3/" .. alphabet[i] .. "/a")
c ("donut/eicas3/" .. alphabet[i] .. "/b")
c ("donut/eicas3/" .. alphabet[i] .. "/c")

cs ("donut/eicasmsg/" .. i)

if i > 5 then
if i < 9 then

c ("donut/eicas/" .. alphabet[i] .. "/a/r")
c ("donut/eicas/" .. alphabet[i] .. "/b/r")
c ("donut/eicas/" .. alphabet[i] .. "/c/r")
c ("donut/eicas2/" .. alphabet[i] .. "/a/r")
c ("donut/eicas2/" .. alphabet[i] .. "/b/r")
c ("donut/eicas2/" .. alphabet[i] .. "/c/r")
c ("donut/eicas3/" .. alphabet[i] .. "/a/r")
c ("donut/eicas3/" .. alphabet[i] .. "/b/r")
c ("donut/eicas3/" .. alphabet[i] .. "/c/r")

cs ("donut/eicasmsg/" .. (i - 5) .. "/r")

end -- end if
end -- end if

if i > 5 then

c ("donut/eicas/" .. alphabet[i] .. "/a/w")
c ("donut/eicas/" .. alphabet[i] .. "/b/w")
c ("donut/eicas/" .. alphabet[i] .. "/c/w")
c ("donut/eicas2/" .. alphabet[i] .. "/a/w")
c ("donut/eicas2/" .. alphabet[i] .. "/b/w")
c ("donut/eicas2/" .. alphabet[i] .. "/c/w")
c ("donut/eicas3/" .. alphabet[i] .. "/a/w")
c ("donut/eicas3/" .. alphabet[i] .. "/b/w")
c ("donut/eicas3/" .. alphabet[i] .. "/c/w")

cs ("donut/eicasmsg/" .. (i - 5) .. "/w")

end -- end if




end -- end for loop

c "donut/a"
c "donut/m"


c "donut/custom/alt"

c "donut/eicas/white"          --How many white are displayed on eicas
c "donut/eicas/customegt"      --Custom EGT for startup
c "donut/eicas/customegt1"     --Custom EGT for startup
c "donut/eicas/customn1"       --Custom N1 for startup
c "donut/eicas/customn11"      --Custom N1 for startup

c "donut/panel/cross"          --Fuel crossfeed button out
ci "donut/panel/fuel1"         --Fuel switch 1
ci "donut/panel/fuel2"         --Fuel switch 2
c "donut/panel/gear"           --Gear Lever



c "donut/panels/MCP/speed"
c "donut/panels/MCP/heading"
c "donut/panels/MCP/vertical"
ci "donut/panels/MCP/altitudexorm"
c "donut/panels/MCP/altitude"
c "donut/panels/MCP/lautothrottle"
c "donut/panels/MCP/rautothrottle"
c "donut/panels/MCP/heading sel"
c "donut/panels/MCP/heading hld"
ci "donut/panels/MCP/lnav"
ci "donut/panels/MCP/vnav"
ci "donut/panels/MCP/clbcon"

ci "donut/panels/MCP/iasmach"
ci "donut/panels/MCP/hdgtrk"
ci "donut/panels/MCP/vsfpa"
ci "donut/panels/MCP/apdisconnect"



ci "donut/panels/EFIS/min"
c "donut/panels/EFIS/knobmin"
ci "donut/panels/EFIS/rst"
ci "donut/panels/EFIS/baro"
c "donut/panels/EFIS/knobbaro"
ci "donut/panels/EFIS/std"
ci "donut/panels/EFIS/FPV"
ci "donut/panels/EFIS/MTRS"
ci "donut/panels/EFIS/vorl"
ci "donut/panels/EFIS/vorr"
ci "donut/panels/EFIS/mapmode"
ci "donut/panels/EFIS/ctr"
ci "donut/panels/EFIS/mapzoom"
ci "donut/panels/EFIS/tfc"



ca ("donut/panels/pedestal/panel1/mic/mic", 10)       --
ca ("donut/panels/pedestal/panel1/mic/recieve", 12)   --
ca ("donut/panels/pedestal/panel1/mic/push", 12)      --
ca ("donut/panels/pedestal/panel1/mic/turn", 12)      --



c "donut/panels/overhead/computer/adiru"
c "donut/panels/overhead/computer/thrustasymcomp"
c "donut/panels/overhead/computer/primaryflightcomputers"

c "donut/panels/overhead/electrical/ifepassseats"
c "donut/panels/overhead/electrical/cabinutility"
c "donut/panels/overhead/electrical/lbustie"
c "donut/panels/overhead/electrical/rbustie"
c "donut/panels/overhead/electrical/ldrivedisc"
c "donut/panels/overhead/electrical/rdrivedisc"
c "donut/panel/ExtpwrPRI"      --primary external power
c "donut/panel/ExtpwrSEC"      --secondary external power
c "donut/panel/ExtpwrPRIavail" --primary external power avail?
c "donut/panel/ExtpwrSECavail" --secondary external power avail?
c "donut/panels/overhead/electrical/lbackupgen"
c "donut/panels/overhead/electrical/rbackupgen"

ci "donut/panels/overhead/lwiper/lwiper"

c "donut/panels/overhead/abvhyd/emerlights"
c "donut/panels/overhead/abvhyd/servintph"
c "donut/panels/overhead/abvhyd/lsidewindowheat"
c "donut/panels/overhead/abvhyd/lfwdwindowheat"
c "donut/panels/overhead/abvhyd/rfwdwindowheat"
c "donut/panels/overhead/abvhyd/rsidewindowheat"

c "donut/panels/overhead/hyd/ramairturbine"
c "donut/panel/hydLPRI"        --primary hydraulics
c "donut/panel/hydC1PRI"       --primary hydraulics
c "donut/panel/hydC2PRI"       --primary hydraulics
c "donut/panel/hydRPRI"        --primary hydraulics
ci "donut/panel/hydLDEM"       --demand hydraulics
ci "donut/panel/hydC1DEM"      --demand hydraulics
ci "donut/panel/hydC2DEM"      --demand hydraulics
ci "donut/panel/hydRDEM"       --demand hydraulics

c "donut/panels/overhead/lights/ovhd"
c "donut/panels/overhead/lights/cb"
c "donut/panels/overhead/lights/dome"
c "donut/panels/overhead/lights/storm"
c "donut/panels/overhead/lights/masterbright"
c "donut/panels/overhead/lights/glareshieldpnl"
c "donut/panels/overhead/lights/flood"
c "donut/panels/overhead/lights/llanding"
c "donut/panels/overhead/lights/nlanding"
c "donut/panels/overhead/lights/rlanding"

c "donut/panels/overhead/engine/fwdarm"
c "donut/panels/overhead/engine/aftarm"
c "donut/panels/overhead/engine/disch"
c "donut/panels/overhead/engine/fireovhttest"
c "donut/panels/overhead/engine/autostart"
ci "donut/panel/start1"        --Starter 1
ci "donut/panel/start2"        --Starter 2

c "donut/panels/overhead/fuel/lnozzle"
c "donut/panels/overhead/fuel/rnozzle"
c "donut/panels/overhead/fuel/arm"
c "donut/panels/overhead/fuel/lfwdpump"
c "donut/panels/overhead/fuel/laftpump"
c "donut/panels/overhead/fuel/fwdcrossfeed"
c "donut/panels/overhead/fuel/aftcrossfeed"
c "donut/panels/overhead/fuel/rfwdpump"
c "donut/panels/overhead/fuel/raftpump"
c "donut/panels/overhead/fuel/lcentrepump"
c "donut/panels/overhead/fuel/rcentrepump"

c "donut/panels/overhead/antiice/icewing"
c "donut/panels/overhead/antiice/icelengine"
c "donut/panels/overhead/antiice/icerengine"
c "donut/panels/overhead/antiice/beacon"
c "donut/panels/overhead/antiice/nav"
c "donut/panels/overhead/antiice/logo"
c "donut/panels/overhead/antiice/wing"
c "donut/panels/overhead/antiice/indlts"
c "donut/panels/overhead/antiice/lrunwayturnoff"
c "donut/panels/overhead/antiice/rrunwayturnoff"
c "donut/panels/overhead/antiice/taxi"
c "donut/panels/overhead/antiice/strobe"

c "donut/panels/overhead/airconditioning/equipcooling"
c "donut/panels/overhead/airconditioning/upper"
c "donut/panels/overhead/airconditioning/lower"
c "donut/panels/overhead/airconditioning/fltdecktemp"
c "donut/panels/overhead/airconditioning/cabintemp"
c "donut/panels/overhead/airconditioning/aircondreset"
c "donut/panels/overhead/airconditioning/lpack"
c "donut/panels/overhead/airconditioning/ltrimair"
c "donut/panels/overhead/airconditioning/rtrimair"
c "donut/panels/overhead/airconditioning/rpack"

c "donut/panels/overhead/bleedair/lisln"
c "donut/panels/overhead/bleedair/cisln"
c "donut/panels/overhead/bleedair/risln"
c "donut/panel/bleedL"         --Bleed air
c "donut/panel/bleedR"         --Bleed air
c "donut/panel/bleedAPU"       --Bleed air
c "donut/panels/overhead/bleedair/fwdoutflowvalve"
c "donut/panels/overhead/bleedair/aftoutflowvalve"
c "donut/panels/overhead/bleedair/ldgalt"
c "donut/panels/overhead/bleedair/fwdmanual"
c "donut/panels/overhead/bleedair/aftmanual"

ci "donut/panels/overhead/rwiper/rwiper"



c "donut/pfd/aoa"              --angle of attack
c "donut/pfd/fup"              --flaps up bug
c "donut/pfd/f1"               --flaps 1
c "donut/pfd/f5"               --flaps 5
c "donut/pfd/f15"              --flaps 15
c "donut/pfd/v1"               --v1 bug
c "donut/pfd/vr"               --vr
c "donut/pfd/v2"               --v2
c "donut/pfd/apprfl"           --FMC approach flaps
c "donut/pfd/apprsp"           --FMC approach speed
c "donut/pfd/altro"            --for altitude rolling tickmarks (altitude / 10)

ci "donut/pfd/fma/speed"
ci "donut/pfd/fma/lateral"
ci "donut/pfd/fma/vertical"
ci "donut/pfd/eicas/trm"       --odd choice of path, the thrust reference mode

c "donut/mcp/spd"
c "donut/mcp/hdg"
c "donut/mcp/vv"
c "donut/mcp/alt"

c "donut/radio1a"              --For HF sensitivity, use a value less than one for A not S radio
c "donut/radio1s"
c "donut/radio2a"
c "donut/radio2s"
c "donut/radio3a"
c "donut/radio3s"
c "donut/transponder"

c "donut/panels/pedestal/panel1/radioIn"
c "donut/panels/pedestal/panel1/radioOut"
c "donut/panels/pedestal/panel1/hfsens"

ca ("donut/panels/pedestal/panel1/button", 9)


ci "donut/pfd/note/mode"
ci "donut/pfd/note/spd"
ci "donut/pfd/note/alt"
ci "donut/pfd/note/vspd"
ci "donut/pfd/note/radioalt"
ci "donut/pfd/note/speed"
ci "donut/pfd/note/lateral"
ci "donut/pfd/note/vertical"
