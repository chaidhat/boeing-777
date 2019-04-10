-- System_Bleed.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

m = 0
frame = 0
su = ""
ss = 0
ll = 0
vv = 0
st = 0
lt = 0
vt = 0
ln1a = 0
rn1a = 0
ln1t = 0
rn1t = 0





function itob (input) -- int to boolean
if input == 0 then
return false
end
return true
end -- end int to boolean

function update ()
	set(globalPropertyf("donut/fltctr/flaperondefl"), (get(globalPropertyf("sim/flightmodel/controls/wing1l_ail1def")) * 0.33) + (get(globalPropertyf("sim/flightmodel2/controls/flap1_deploy_ratio"))*20))
	set(globalPropertyf("donut/fltctr/flaperondefr"), (get(globalPropertyf("sim/flightmodel/controls/wing1l_ail1def")) * (0 - 0.33)) + (get(globalPropertyf("sim/flightmodel2/controls/flap1_deploy_ratio"))*20))

		if itob(get(globalPropertyi("donut/panels/MCP/fd"))) then
			if itob(get(globalPropertyi("donut/panels/MCP/ap"))) then
				set(globalPropertyi("sim/cockpit/autopilot/autopilot_mode"), 2)
			else
				set(globalPropertyi("sim/cockpit/autopilot/autopilot_mode"), 1)
			end
		else
			set(globalPropertyi("donut/panels/MCP/ap"), 0)
			set(globalPropertyi("sim/cockpit/autopilot/autopilot_mode"), 0)
		end

	s = get(globalPropertys("donut/pfd/fma/speed")) 
l = get(globalPropertys("donut/pfd/fma/lateral"))
v = get(globalPropertys("donut/pfd/fma/vertical"))

if not (ss == s) then
	ss = s
	st = get(globalPropertyf("sim/time/local_time_sec"))
end
if not (ll == l) then
	ll = l
	lt = get(globalPropertyf("sim/time/local_time_sec"))
end
if not (vv == v) then
	vv = v
	vt = get(globalPropertyf("sim/time/local_time_sec"))
end

if ((get(globalPropertyf("sim/time/local_time_sec")) - st) < 5) and ((get(globalPropertyf("sim/time/local_time_sec")) - st) > 0) then
	set(globalPropertyf("donut/pfd/note/speed"), 1)
else
	set(globalPropertyf("donut/pfd/note/speed"), 0)
end
if ((get(globalPropertyf("sim/time/local_time_sec")) - lt) < 5) and ((get(globalPropertyf("sim/time/local_time_sec")) - lt) > 0) then
	set(globalPropertyf("donut/pfd/note/lateral"), 1)
else
	set(globalPropertyf("donut/pfd/note/lateral"), 0)
end
if ((get(globalPropertyf("sim/time/local_time_sec")) - vt) < 5) and ((get(globalPropertyf("sim/time/local_time_sec")) - vt) > 0) then
	set(globalPropertyf("donut/pfd/note/vertical"), 1)
else
	set(globalPropertyf("donut/pfd/note/vertical"), 0)
end

frame = frame + 1






if not (su == "f") then
	if get(globalPropertyf("donut/panels/MCP/at")) == 1 then
		if get(globalPropertyf("sim/flightmodel/misc/h_ind")) < 400 then

			if not ((s == "l spd") or (s == "r spd") or (s == "spd")) then
				if get(globalPropertyf("sim/flightmodel/position/indicated_airspeed")) > 80 then
					set(globalPropertys("donut/pfd/fma/speed"), su .. "hold")
					ln1t = 2
				else
					set(globalPropertys("donut/pfd/fma/speed"), su .. "thr ref")
					ln1t = 1
					rn1t = 1
				end	
			else
				if get(globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")) < 26 then
					set(globalPropertys("donut/pfd/fma/speed"), su .. "idle")
					ln1t = 0
					rn1t = 0
				else
					set(globalPropertys("donut/pfd/fma/speed"), su .. "spd")
					if ln1t == 2 then
						ln1t = 1
						rn1t = 1
					end
				end
			end

		else

			if v == "vnav spd" then
				set(globalPropertys("donut/pfd/fma/speed"), su .. "thr ref")
				ln1t = 0.8
				rn1t = 0.8
			else if v == "flch spd" then
				if get(globalPropertyf("sim/cockpit/autopilot/vertical_velocity")) > 0 then
					set(globalPropertys("donut/pfd/fma/speed"), su .. "thr ref")
					ln1t = 0.8
					rn1t = 0.8
				else
					if (get(globalPropertyf("donut/eicas/ln1")) == 0) and (get(globalPropertyf("donut/eicas/rn1")) == 0) then
						set(globalPropertys("donut/pfd/fma/speed"), su .. "hold")
						ln1t = 2
					else
						set(globalPropertys("donut/pfd/fma/speed"), su .. "idle")
						if ln1t == 2 then
							ln1t = 1
						rn1n1t = 1
						end
					end
				end
			else
				set(globalPropertys("donut/pfd/fma/speed"), su .. "spd")
				if ln1t == 2 then
					ln1t = 1
					rn1t = 1
				end
			end
			end
		end
	else
		set(globalPropertys("donut/pfd/fma/speed"), "")
		ln1t = 2
	end
else
	set(globalPropertys("donut/pfd/fma/speed"), "")
	ln1t = 2
end











if (get(globalPropertyf("sim/time/sim_speed")) > 0) then
	if ((s == "l spd") or (s == "r spd") or (s == "spd")) then
	if (get(globalPropertyf("sim/cockpit/autopilot/airspeed")) - get(globalPropertyf("sim/flightmodel/position/indicated_airspeed"))) > 5 then
		if (get(globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_acceleration_kts_sec_pilot")) - 3) / (-5) < 1 then
				ln1t = (get(globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_acceleration_kts_sec_pilot")) - 3) / (-5)
				rn1t = (get(globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_acceleration_kts_sec_pilot")) - 3) / (-5)
			else
				ln1t = 0.9
				rn1t = 0.9
			end
		print(ln1t)
	else

		if (get(globalPropertyf("sim/flightmodel/position/indicated_airspeed")) - get(globalPropertyf("sim/cockpit/autopilot/airspeed"))) > 5 then

		print(get(globalPropertyf("sim/flightmodel/position/indicated_airspeed")) - get(globalPropertyf("sim/cockpit/autopilot/airspeed")))
			if ln1t > 0 then
				ln1t = ln1t - 0.02
				rn1t = rn1t - 0.02
				print(ln1t)
			end
		end
	end
	end

	if (frame % 2 == 0) then
		if itob(get(globalPropertyf("donut/panels/MCP/lautothrottle"))) then
			if (ln1t < 2) then
				if get(globalPropertyf("donut/eicas/ln1")) < ln1t then
					sasl.commandOnce(sasl.findCommand("sim/engines/throttle_up_1"))
				end
				if get(globalPropertyf("donut/eicas/ln1")) > ln1t then
					sasl.commandOnce(sasl.findCommand("sim/engines/throttle_down_1"))
				end
			end
			if not itob(get(globalPropertyf("donut/panels/MCP/rautothrottle"))) then
				su = "l "
			end
			ln1a = get(globalPropertyf("donut/eicas/ln1"))
		end

		if itob(get(globalPropertyf("donut/panels/MCP/rautothrottle"))) then
			if (ln1t < 2) then
				if get(globalPropertyf("donut/eicas/rn1")) < rn1t then
					sasl.commandOnce(sasl.findCommand("sim/engines/throttle_up_2"))
				end

				if get(globalPropertyf("donut/eicas/rn1")) > rn1t then
					sasl.commandOnce(sasl.findCommand("sim/engines/throttle_down_2"))
				end
			end
			if not itob(get(globalPropertyf("donut/panels/MCP/lautothrottle"))) then
				su = "r "
			else
				su = ""
			end
			rn1a = get(globalPropertyf("donut/eicas/ln1"))
		else
			if not itob(get(globalPropertyf("donut/panels/MCP/lautothrottle"))) then
				su = "f"
				set(globalPropertyf("donut/panels/MCP/at"), 0)
			end
		end
	else
		if not (ln1a == get(globalPropertyf("donut/eicas/ln1"))) then
			--sasl.commandOnce(sasl.findCommand("sim/autopilot/autothrottle_off"))
			--ln1t = 2
		end

		if not (rn1a == get(globalPropertyf("donut/eicas/rn1"))) then
			--sasl.commandOnce(sasl.findCommand("sim/autopilot/autothrottle_off"))
			--ln1t = 2
		end
	end
end




x = 0
if get(globalPropertyf("sim/cockpit/autopilot/autopilot_mode")) > 0 then
	if get(globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")) < 50 then
		set(globalPropertys("donut/pfd/fma/lateral"), "to ga")
	else
		
		if (get(globalPropertyf("donut/panels/MCP/headinghld")) == 1) then
			if (get(globalPropertyf("donut/panels/MCP/hdgtrk")) == 0) and (l == "trk hold") then
				set(globalPropertys("donut/pfd/fma/lateral"), "hdg hold")
				sasl.commandOnce(sasl.findCommand("sim/autopilot/heading_sync"))
				sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
				l = "hdg hold"
			else
				if (not (get(globalPropertyf("donut/panels/MCP/hdgtrk")) == 0)) and (l == "hdg hold") then
					set(globalPropertys("donut/pfd/fma/lateral"), "trk hold")
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading_sync"))
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
					l = "trk hold"
				end
			end
			if (not (l == "hdg hold")) and (not (l == "trk hold")) then
				set(globalPropertyf("donut/panels/MCP/headingsel"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/heading_mode"), 15)
				set(globalPropertyf("sim/cockpit2/autopilot/nav_status"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/approach_status"), 0)

				if get(globalPropertyf("donut/panels/MCP/hdgtrk")) == 0 then
					set(globalPropertys("donut/pfd/fma/lateral"), "hdg hold")
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading_sync"))
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
					l = "hdg hold"
				else
					set(globalPropertys("donut/pfd/fma/lateral"), "trk hold")
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading_sync"))
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
					l = "trk hold"
				end
			end
			x = 1
		end

		if (get(globalPropertyf("donut/panels/MCP/headingsel")) == 1) then
			if (get(globalPropertyf("donut/panels/MCP/hdgtrk")) == 0) and (l == "trk sel") then
				set(globalPropertys("donut/pfd/fma/lateral"), "hdg sel")
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
					l = "hdg sel"
			else
				if (not (get(globalPropertyf("donut/panels/MCP/hdgtrk")) == 0)) and (l == "hdg sel") then
					set(globalPropertys("donut/pfd/fma/lateral"), "trk sel")
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
					l = "trk sel"
				end
			end
			if (not (l == "hdg sel")) and (not (l == "trk sel")) then
				set(globalPropertyf("donut/panels/MCP/headinghld"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/heading_mode"), 15)
				set(globalPropertyf("sim/cockpit2/autopilot/nav_status"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/approach_status"), 0)

				if get(globalPropertyf("donut/panels/MCP/hdgtrk")) == 0 then
					set(globalPropertys("donut/pfd/fma/lateral"), "hdg sel")
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
					l = "hdg sel"
				else
					set(globalPropertys("donut/pfd/fma/lateral"), "trk sel")
					sasl.commandOnce(sasl.findCommand("sim/autopilot/heading"))
					l = "trk sel"
				end
			end
			x = 1
		end

		if (get(globalPropertyf("sim/cockpit2/autopilot/nav_status")) == 2) then
			if not (l == "loc") then
				set(globalPropertyf("donut/panels/MCP/headinghld"), 0)
				set(globalPropertyf("donut/panels/MCP/headingsel"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/heading_mode"), 15)
				set(globalPropertyf("sim/cockpit2/autopilot/approach_status"), 0)

				set(globalPropertys("donut/pfd/fma/lateral"), "loc")
				l = "loc"
			end
			x = 1
		end
		if x == 0 then
			set(globalPropertys("donut/pfd/fma/lateral"), "att")
				l = "att"
		end
		
	end
	if (get(globalPropertyf("sim/flightmodel/misc/h_ind")) < 400) or ((get(globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")) < 50) and ((s == "l spd") or (s == "r spd") or (s == "spd"))) then
		if (get(globalPropertyf("sim/flightmodel/misc/h_ind")) < 400) then
			set(globalPropertys("donut/pfd/fma/vertical"), "to ga")
		else
			set(globalPropertys("donut/pfd/fma/vertical"), "flare")
		end
	else
		x = 0

		if (get(globalPropertyf("donut/panels/MCP/flch")) == 1) then
			if not (v == "flch spd") then
				set(globalPropertyf("donut/panels/MCP/alts"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/altitude_mode"), 3)
				set(globalPropertyf("donut/panels/MCP/vvis"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/approach_status"), 0)
				set(globalPropertyf("donut/panels/MCP/vnav"), 0)



				set(globalPropertyf("sim/cockpit2/autopilot/vertical_velocity"), (get(globalPropertyf("sim/flightmodel/misc/h_ind")) - get(globalPropertyf("sim/cockpit/autopilot/altitude"))) / 2)
				sasl.commandOnce(sasl.findCommand("sim/autopilot/vertical_speed"))
				set(globalPropertys("donut/pfd/fma/vertical"), "flch spd")
			end
			x = 1
		end

		if (get(globalPropertyf("sim/cockpit2/autopilot/altitude_mode")) == 6) then
			if not (v == "alt") then
				set(globalPropertyf("donut/panels/MCP/alts"), 1)
				set(globalPropertyf("donut/panels/MCP/flch"), 0)
				set(globalPropertyf("donut/panels/MCP/vvis"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/approach_status"), 0)
				set(globalPropertyf("donut/panels/MCP/vnav"), 0)

				set(globalPropertys("donut/pfd/fma/vertical"), "alt")
				v = "alt"
			end
			x = 1
		end

		if (get(globalPropertyf("sim/cockpit2/autopilot/altitude_mode")) == 4) and (get(globalPropertyf("donut/panels/MCP/flch")) == 0) then
			print(v)
			if (get(globalPropertyf("donut/panels/MCP/vsfpa")) == 0) and (v == "fpa") then
				set(globalPropertys("donut/pfd/fma/vertical"), "v s")
				v = "v s"
			else
				if (not (get(globalPropertyf("donut/panels/MCP/vsfpa")) == 0) and (v == "v s")) then
					set(globalPropertys("donut/pfd/fma/vertical"), "fpa")
					v = "fpa"
				end
			end
			if (not (v == "v s")) and (not (v == "fpa")) then
				set(globalPropertyf("donut/panels/MCP/alts"), 0)
				set(globalPropertyf("donut/panels/MCP/flch"), 0)
				set(globalPropertyf("donut/panels/MCP/vvis"), 1)
				set(globalPropertyf("sim/cockpit2/autopilot/approach_status"), 0)
				set(globalPropertyf("donut/panels/MCP/vnav"), 0)
				
				if get(globalPropertyf("donut/panels/MCP/vsfpa")) == 0 then
					set(globalPropertys("donut/pfd/fma/vertical"), "v s")
					v = "v s"
				else
				set(globalPropertys("donut/pfd/fma/vertical"), "fpa")
					v = "fpa"
				end
			end
			x = 1
		end

		if (get(globalPropertyf("sim/cockpit2/autopilot/approach_status")) == 2) then
			if not (v == "g s") then
				set(globalPropertyf("donut/panels/MCP/alts"), 0)
				set(globalPropertyf("sim/cockpit2/autopilot/altitude_mode"), 3)
				set(globalPropertyf("donut/panels/MCP/flch"), 0)
				set(globalPropertyf("donut/panels/MCP/vvis"), 0)
				set(globalPropertyf("donut/panels/MCP/vnav"), 0)
				
				set(globalPropertys("donut/pfd/fma/vertical"), "g s")
				v = "g s"
			end
			x = 1
		end
		if x == 0 then
			set(globalPropertys("donut/pfd/fma/vertical"), "")
			v = ""
		end
	end
else
	set(globalPropertys("donut/pfd/fma/lateral"), "")
	set(globalPropertys("donut/pfd/fma/vertical"), "")
end

if get(globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")) > 10 then
	if get(globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")) < 11 then
		x = get(globalPropertyf("xfmc/airbus/V2")) or 110
		set(globalPropertyf("sim/cockpit/autopilot/airspeed"), get(x) + 15)
		sasl.commandOnce(sasl.findCommand("sim/autopilot/level_change"))
	end
end


end -- end update

