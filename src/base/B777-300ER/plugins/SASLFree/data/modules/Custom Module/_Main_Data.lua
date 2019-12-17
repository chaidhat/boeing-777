-- _Main_Datarefs.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

local a = 0
local coldDark = {}
local init = 0

function d (name, default, onColdDark) -- creates dataref
	default = default or 1.0
	coldDark[a] = onColdDark

	defineProperty("x" .. a, createGlobalPropertyf(name, default, false, true))
	a = a + 1

end -- end d

function di(name, default, onColdDark) -- creates dataref as int
	default = default or 1.0
	coldDark[a] = onColdDark

	defineProperty("x" .. a, createGlobalPropertyi(name, default, false, true))
	a = a + 1

end -- end di

function da(name, length) -- creates an array for similar variables
	for i = 0, length, 1 do
	    d (name .. i, 0)

	
	end -- end for
end -- end da

function ds(name) -- creates string dataref
	defineProperty("x" .. a, createGlobalPropertys(name, "", false, true))
	a = a + 1

end -- end ds

function dd(name, noDigits) -- creates digit datarefs
	noDigits = noDigits or 1

	if noDigits == 1 then
		for j = 1, 7, 1 do
			d(name .. "/" .. j)
		end
	else
		for i = 1, noDigits, 1 do
			for j = 1, 7, 1 do
				d(name .. "/" .. i .. "/" .. j)
			end
		end
	end

end -- end ds



function update ()

	if not init then -- initialisation
		set(globalPropertyf("sim/flightmodel/misc/cgz_ref_to_default"), 0.736332)
		set(globalPropertyi("sim/cockpit/engine/APU_switch"), 0)

		for i = 1, table.getn(coldDark), 1 do
			set("x" .. i, coldDark[i])
		end

		init = true

	end -- end if

end -- end update

for i = 1, 11, 1 do -- defines EICAS datarefs (189)

	ds ("donut/eicasmsg/" .. i)
	ds ("donut/eicasmsg/" .. i .. "/r")
	ds ("donut/eicasmsg/" .. i .. "/w")

end -- end for loop



if get(globalPropertyf("sim/time/total_flight_time_sec")) > 1 then
	createGlobalPropertyf("donut/a", 1, false, true)
else
	createGlobalPropertyf("donut/a", 0, false, true)
end

d ("donut/a", 0)
d "donut/m"

d "donut/engine/aero"


di ("donut/copyrightmessage", 0)
d "donut/custom/alt"

d "donut/eicas/white"          --How many white are displayed on eicas
d "donut/eicas/customegt"      --Custom EGT for startup
d "donut/eicas/customegt1"     --Custom EGT for startup
d "donut/eicas/customn1"       --Custom N1 for startup
d "donut/eicas/customn11"      --Custom N1 for startup
d "donut/eicas/ln1"
d "donut/eicas/rn1"
d "donut/eicas/ln1show"
d "donut/eicas/rn1show"
d "donut/eicas/ln1show2"
d "donut/eicas/rn1show2"

d "donut/fuel/qtyl"
d "donut/fuel/qtyc"
d "donut/fuel/qtyr"
d "donut/eng/vibl"
d "donut/eng/vibr"
di ("donut/eng/oql", 25)
di ("donut/eng/oqr", 25)
di ("donut/eng/egtstrtl", 700)
di ("donut/eng/egtstrtr", 700)

d "donut/panel/cross"          --Fuel crossfeed button out
d "donut/panel/fuel1"         --Fuel switch 1
d "donut/panel/fuel2"         --Fuel switch 2
d "donut/panel/gear"           --Gear Lever

d "donut/panels/throttle_column/fuel_control_switch_l_pos"
d "donut/panels/throttle_column/fuel_control_switch_r_pos"

dd ("donut/digits/radio1/a", 6)
dd ("donut/digits/radio1/s", 6)
dd ("donut/digits/xpndr", 4)

dd ("donut/digits/mcp/spd", 3)
dd ("donut/digits/mcp/hdg", 3)
dd ("donut/digits/mcp/vs", 4)
dd ("donut/digits/mcp/alt", 5)

d "donut/panels/MCP/speed"
d "donut/panels/MCP/heading"
d "donut/panels/MCP/vertical"
di "donut/panels/MCP/altitudexorm"
d "donut/panels/MCP/altitude"
di "donut/panels/MCP/lautothrottle"
di "donut/panels/MCP/rautothrottle"
di "donut/panels/MCP/headingsel"
di "donut/panels/MCP/headinghld"
di "donut/panels/MCP/lnav"
di "donut/panels/MCP/vnav"
di "donut/panels/MCP/clbcon"
di "donut/panels/MCP/flchs"
di "donut/panels/MCP/vvis"
di "donut/panels/MCP/alts"
di ("donut/panels/MCP/at", 0)
di ("donut/panels/MCP/flch", 0)

di "donut/panels/MCP/fd"
di ("donut/panels/MCP/ap", 0)


di ("donut/panels/MCP/iasmach", 0)
di ("donut/panels/MCP/hdgtrk", 0)
di ("donut/panels/MCP/vsfpa", 0)
di ("donut/panels/MCP/apdisconnect", 0)



di "donut/panels/EFIS/min"
di ("donut/panels/EFIS/knobmin", 40)
di ("donut/panels/EFIS/rst", 0)
di "donut/panels/EFIS/baro"
di ("donut/panels/EFIS/knobbaro", 50)
di ("donut/panels/EFIS/std", 0)
di ("donut/panels/EFIS/FPV", 0)
di ("donut/panels/EFIS/MTRS", 0)
di "donut/panels/EFIS/vorl"
di "donut/panels/EFIS/vorr"
di "donut/panels/EFIS/mapmode"
di "donut/panels/EFIS/ctr"
di "donut/panels/EFIS/mapzoom"
di "donut/panels/EFIS/tfc"



da ("donut/panels/pedestal/panel1/mic/mic", 10)       --
da ("donut/panels/pedestal/panel1/mic/recieve", 12)   --
da ("donut/panels/pedestal/panel1/mic/push", 12)      --
da ("donut/panels/pedestal/panel1/mic/turn", 12)      --

da ("donut/panels/pedestal/panel2/mic/mic", 10)       --
da ("donut/panels/pedestal/panel2/mic/recieve", 12)   --
da ("donut/panels/pedestal/panel2/mic/push", 12)      --
da ("donut/panels/pedestal/panel2/mic/turn", 12)      --



d "donut/panels/overhead/computer/adiru"
d "donut/panels/overhead/computer/thrustasymcomp"
d "donut/panels/overhead/computer/primaryflightcomputers"

d "donut/panels/overhead/electrical/ifepassseats"
d "donut/panels/overhead/electrical/cabinutility"
d "donut/panels/overhead/electrical/lbustie"
d "donut/panels/overhead/electrical/rbustie"
d ("donut/panels/overhead/electrical/ldrivedisc", 0)
d ("donut/panels/overhead/electrical/rdrivedisc", 0)
d ("donut/panel/ExtpwrPRI", 0) --primary external power
d ("donut/panel/ExtpwrSEC", 0) --secondary external power
d "donut/panel/ExtpwrPRIavail" --primary external power avail?
d "donut/panel/ExtpwrSECavail" --secondary external power avail?
d "donut/panels/overhead/electrical/lbackupgen"
d "donut/panels/overhead/electrical/rbackupgen"

di "donut/panels/overhead/lwiper/lwiper"

d "donut/panels/overhead/abvhyd/emerlights"
d "donut/panels/overhead/abvhyd/servintph"
d "donut/panels/overhead/abvhyd/lsidewindowheat"
d "donut/panels/overhead/abvhyd/lfwdwindowheat"
d "donut/panels/overhead/abvhyd/rfwdwindowheat"
d "donut/panels/overhead/abvhyd/rsidewindowheat"

d "donut/panels/overhead/hyd/ramairturbine"
d "donut/panel/hydLPRI"        --primary hydraulics
d "donut/panel/hydC1PRI"       --primary hydraulics
d "donut/panel/hydC2PRI"       --primary hydraulics
d "donut/panel/hydRPRI"        --primary hydraulics
di "donut/panel/hydLDEM"       --demand hydraulics
di "donut/panel/hydC1DEM"      --demand hydraulics
di "donut/panel/hydC2DEM"      --demand hydraulics
di "donut/panel/hydRDEM"       --demand hydraulics

d "donut/panels/overhead/lights/ovhd"
d "donut/panels/overhead/lights/cb"
d "donut/panels/overhead/lights/dome"
d "donut/panels/overhead/lights/storm"
d "donut/panels/overhead/lights/masterbright"
d "donut/panels/overhead/lights/glareshieldpnl"
d "donut/panels/overhead/lights/flood"
d "donut/panels/overhead/lights/llanding"
d "donut/panels/overhead/lights/nlanding"
d "donut/panels/overhead/lights/rlanding"

d "donut/fltctr/flaperondefl"
d "donut/fltctr/flaperondefr"

d "donut/panels/overhead/engine/fwdarm"
d "donut/panels/overhead/engine/aftarm"
d "donut/panels/overhead/engine/disch"
d "donut/panels/overhead/engine/fireovhttest"
d "donut/panels/overhead/engine/autostart"
di ("donut/panel/start1", 0)        --Starter 1
di ("donut/panel/start2", 0)        --Starter 2

d "donut/panels/overhead/fuel/lnozzle"
d "donut/panels/overhead/fuel/rnozzle"
d "donut/panels/overhead/fuel/arm"
d "donut/panels/overhead/fuel/lfwdpump"
d "donut/panels/overhead/fuel/laftpump"
d ("donut/panels/overhead/fuel/fwdcrossfeed", 0)
d ("donut/panels/overhead/fuel/aftcrossfeed", 0)
d "donut/panels/overhead/fuel/rfwdpump"
d "donut/panels/overhead/fuel/raftpump"
d "donut/panels/overhead/fuel/lcentrepump"
d "donut/panels/overhead/fuel/rcentrepump"

d "donut/panels/overhead/antiice/icewing"
d "donut/panels/overhead/antiice/icelengine"
d "donut/panels/overhead/antiice/icerengine"
d "donut/panels/overhead/antiice/beacon"
d "donut/panels/overhead/antiice/nav"
d "donut/panels/overhead/antiice/logo"
d "donut/panels/overhead/antiice/wing"
d "donut/panels/overhead/antiice/indlts"
d "donut/panels/overhead/antiice/lrunwayturnoff"
d "donut/panels/overhead/antiice/rrunwayturnoff"
d "donut/panels/overhead/antiice/taxi"
d "donut/panels/overhead/antiice/strobe"

d "donut/panels/overhead/airconditioning/equipcooling"
d "donut/panels/overhead/airconditioning/upper"
d "donut/panels/overhead/airconditioning/lower"
d "donut/panels/overhead/airconditioning/fltdecktemp"
d "donut/panels/overhead/airconditioning/cabintemp"
d "donut/panels/overhead/airconditioning/aircondreset"
d "donut/panels/overhead/airconditioning/lpack"
d "donut/panels/overhead/airconditioning/ltrimair"
d "donut/panels/overhead/airconditioning/rtrimair"
d "donut/panels/overhead/airconditioning/rpack"

d "donut/panels/overhead/bleedair/lisln"
d "donut/panels/overhead/bleedair/cisln"
d "donut/panels/overhead/bleedair/risln"
d "donut/panel/bleedL"         --Bleed air
d "donut/panel/bleedR"         --Bleed air
d "donut/panel/bleedAPU"       --Bleed air
d "donut/panels/overhead/bleedair/fwdoutflowvalve"
d "donut/panels/overhead/bleedair/aftoutflowvalve"
d "donut/panels/overhead/bleedair/ldgalt"
d "donut/panels/overhead/bleedair/fwdmanual"
d "donut/panels/overhead/bleedair/aftmanual"

di "donut/panels/overhead/rwiper/rwiper"



d "donut/pfd/aoa"              --angle of attack
d "donut/pfd/fup"              --flaps up bug
d "donut/pfd/f1"               --flaps 1
d "donut/pfd/f5"               --flaps 5
d "donut/pfd/f15"              --flaps 15
d "donut/pfd/v1"               --v1 bug
d "donut/pfd/vr"               --vr
d "donut/pfd/vrf"              --vrf
d "donut/pfd/v2"               --v2
d "donut/pfd/apprfl"           --FMd approach flaps
d "donut/pfd/apprsp"           --FMd approach speed
d "donut/pfd/altro"            --for altitude rolling tickmarks (altitude / 10)
d "donut/pfd/spdro"            --for speed rolling indicator

ds "donut/pfd/fma/speed"
ds "donut/pfd/fma/lateral"
ds "donut/pfd/fma/vertical"
ds "donut/pfd/eicas/trm"       --odd choice of path, the thrust reference mode

d "donut/mcp/spd"
d "donut/mcp/hdg"
d "donut/mcp/vv"
d "donut/mcp/alt"

d "donut/radio1a"              --For HF sensitivity, use a value less than one for A not S radio
d "donut/radio1s"
d "donut/radio2a"
d "donut/radio2s"
d "donut/radio3a"
d "donut/radio3s"
d "donut/transponder"

d "donut/panels/pedestal/panel1/radioIn"
di "donut/panels/pedestal/panel1/radioOut"
d ("donut/panels/pedestal/panel1/hfsens", 75)

di "donut/panels/pedestal/panel1/radio/dual"
di "donut/panels/pedestal/panel1/radio/standby"
di "donut/panels/pedestal/panel1/radio/lvhf"
di "donut/panels/pedestal/panel1/radio/cvhf"
di "donut/panels/pedestal/panel1/radio/rvhf"
di "donut/panels/pedestal/panel1/radio/lhf"
di "donut/panels/pedestal/panel1/radio/toggle"
di "donut/panels/pedestal/panel1/radio/rhf"
di "donut/panels/pedestal/panel1/radio/am"


di "donut/pfd/note/mode"
di "donut/pfd/note/spd"
di "donut/pfd/note/alt"
di "donut/pfd/note/vspd"
di "donut/pfd/note/radioalt"
di "donut/pfd/note/speed"
di "donut/pfd/note/lateral"
di "donut/pfd/note/vertical"

di "donut/pfd/minmode"
d "donut/pfd/barodisplay"

di "donut/panels/efis/sta"
di "donut/panels/efis/wpt"
di "donut/panels/efis/pos"
di "donut/panels/efis/data"
di "donut/panels/efis/terr"
