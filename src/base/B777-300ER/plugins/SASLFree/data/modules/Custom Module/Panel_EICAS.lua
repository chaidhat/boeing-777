-- Panel_EICAS.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

function update ()



lthr = get(globalPropertyfae("sim/flightmodel/engine/ENGN_thro", 1))
rthr = get(globalPropertyfae("sim/flightmodel/engine/ENGN_thro", 2))

ln1 = get(globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 1))
rn1 = get(globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 2))

lthr = ((79 * (((((lthr*0.67)+0.33) * 100) - 33) / 67)) + 21) / 100;
rthr = ((79 * (((((rthr*0.67)+0.33) * 100) - 33) / 67)) + 21) / 100;

set(globalPropertyf("donut/pfd/spdro"), get(globalPropertyf("sim/flightmodel/position/indicated_airspeed")) * 0.5)
set(globalPropertyfae("sim/cockpit2/switches/instrument_brightness_ratio", 8), get(globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")) * 0.01)
set(globalPropertyf("donut/eicas/ln1show2"), (((lthr-(ln1/100))>0.01) and 1 or 0))
set(globalPropertyf("donut/eicas/rn1show2"), (((lthr-(ln1/100))>0.01) and 1 or 0))
set(globalPropertyf("donut/eicas/ln1show"), ((math.abs(lthr-(ln1/100))>0.01) and 0 or 1))
set(globalPropertyf("donut/eicas/rn1show"), ((math.abs(rthr-(rn1/100))>0.01) and 0 or 1))
set(globalPropertyf("donut/eicas/ln1"), lthr)
set(globalPropertyf("donut/eicas/rn1"), rthr)
end -- end update
