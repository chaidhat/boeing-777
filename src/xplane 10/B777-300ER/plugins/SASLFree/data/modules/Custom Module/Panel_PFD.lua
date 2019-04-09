-- Panel_PFD.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0





frame = 0

function modFloat (a, b) -- Preforms modulus operation (for redundant coe, should be removed, do CMD + F)

while (a > 0) do
    a = a - b;
end
return a + b;
end -- end modFloat

function update ()

if frame == 0 then
set(globalPropertyi("sim/cockpit2/EFIS/EFIS_tcas_on"), 1)
end

if get(globalPropertyi("donut/panels/efis/sta")) == 1 then
set(globalPropertyi("sim/cockpit2/EFIS/EFIS_vor_on"), 1)
set(globalPropertyi("sim/cockpit2/EFIS/EFIS_ndb_on"), 1)
else
set(globalPropertyi("sim/cockpit2/EFIS/EFIS_vor_on"), 0)
set(globalPropertyi("sim/cockpit2/EFIS/EFIS_ndb_on"), 0)
end
if get(globalPropertyi("donut/panels/efis/wpt")) == 1 then
set(globalPropertyi("sim/cockpit2/EFIS/EFIS_fix_on"), 1)
else
set(globalPropertyi("sim/cockpit2/EFIS/EFIS_fix_on"), 0)

end
if get(globalPropertyi("donut/panels/efis/pos")) == 1 then
end
if get(globalPropertyi("donut/panels/efis/data")) == 1 then
end
if get(globalPropertyi("donut/panels/efis/terr")) == 1 then
end

if get(globalPropertyf("sim/cockpit2/EFIS/map_mode")) == 3 then
set(globalPropertyf("sim/cockpit2/EFIS/map_mode"), 4)
end

frame = frame + 1

set(globalPropertyf("donut/pfd/aoa"), (get(globalPropertyf("sim/flightmodel/position/theta")) - get(globalPropertyf("sim/flightmodel/position/alpha")) + 10) - get(globalPropertyf("sim/flightmodel/position/theta")))

xxy = get(globalPropertyf("sim/flightmodel/position/indicated_airspeed"))
xyx = (((get(globalPropertyf("sim/flightmodel/weight/m_total")) - 167830) / 184610) * 50)
if ((200 + xyx) - xxy < 60 and (200 + xyx) - xxy > -60) then
    set(globalPropertyf("donut/pfd/fup"), (200 + xyx) - xxy)
else  set(globalPropertyf("donut/pfd/fup"), 100) end
if ((180 + xyx) - xxy < 60 and (180 + xyx) - xxy > -60) then
    set(globalPropertyf("donut/pfd/f1"), (180 + xyx) - xxy)
else  set(globalPropertyf("donut/pfd/f1"), 100) end
if ((160 + xyx) - xxy < 60 and (160 + xyx) - xxy > -60) then
    set(globalPropertyf("donut/pfd/f5"), (160 + xyx) - xxy)
else  set(globalPropertyf("donut/pfd/f5"), 100) end
if ((145 + xyx) - xxy < 60 and (145 + xyx) - xxy > -60) then
    set(globalPropertyf("donut/pfd/f15"), (145 + xyx) - xxy)
else  set(globalPropertyf("donut/pfd/f15"), 100) end

set(globalPropertyf("donut/pfd/altro"), ((modFloat(get(globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")), 1000) + 100) / 600) + 2.0622)


set(globalPropertyi("donut/pfd/minmode"), get(globalPropertyi("donut/panels/EFIS/min")) == 40 and (get(globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")) > get(globalPropertyf("sim/cockpit/misc/radio_altimeter_minimum")) and 1 or 2) or 0)

--[[ci "donut/panels/EFIS/min"
ci "donut/panels/EFIS/knobmin"
ci "donut/panels/EFIS/rst"
ci "donut/panels/EFIS/baro"
ci "donut/panels/EFIS/knobbaro"
ci "donut/panels/EFIS/std"
ci "donut/panels/EFIS/FPV"
ci "donut/panels/EFIS/MTRS"
ci "donut/panels/EFIS/vorl"
ci "donut/panels/EFIS/vorr"
ci "donut/panels/EFIS/mapmode"
ci "donut/panels/EFIS/ctr"
ci "donut/panels/EFIS/mapzoom"
ci "donut/panels/EFIS/tfc"--]]




--[[sim/cockpit2/EFIS/
EFIS controls - all actuators.

map_mode	int	900+	yes	enum	Map mode. 0=approach, 1=vor,2=map,3=nav,4=plan
map_mode_is_HSI	int	900+	yes	boolean	Map is in HSI mode, 0 or 1.
map_range	int	900+	yes	enum	Map range, 1->6, where 6 is the longest range.
argus_mode	int	900+	yes	enum	Argus mode, 7=departure,8=enroute,9=approach,10=radar_on
ecam_mode	int	900+	yes	enum	ECAM mode, 0=engine,1=fuel,2=controls,3=hydraulics,4=failures
EFIS_weather_on	int	900+	yes	boolean	On the moving map, show the weather or not.
EFIS_tcas_on	int	900+	yes	boolean	On the moving map, show the TCAS or not.
EFIS_airport_on	int	900+	yes	boolean	On the moving map, show the airports or not.
EFIS_fix_on	int	900+	yes	boolean	On the moving map, show the fixes or not.
EFIS_vor_on	int	900+	yes	boolean	On the moving map, show the VORs or not.
EFIS_ndb_on	int	900+	yes	boolean	On the moving map, show the NDBs or not.
EFIS_1_selection_pilot	int	900+	yes	enum	EFIS waypoint 1 is showing: 0=ADF1, 1=OFF, or 2=VOR1 -- Pilot
EFIS_1_selection_copilot	int	900+	yes	enum	EFIS waypoint 2 is showing: 0=ADF1, 1=OFF, or 2=VOR1 -- Copilot
EFIS_2_selection_pilot	int	900+	yes	enum	EFIS waypoint 1 is showing: 0=ADF2, 1=OFF, or 2=VOR2 -- Pilot
EFIS_2_selection_copilot	int	900+	yes	enum	EFIS waypoint 2 is showing: 0=ADF2, 1=OFF, or 2=VOR2 -- Copilot
EFIS_page





--]]

end -- end update
