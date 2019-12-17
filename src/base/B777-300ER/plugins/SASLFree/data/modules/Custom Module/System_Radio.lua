-- System_Radio.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

r1_mode = "vhf l"
r1_vhf_l_a = get(globalPropertyf("sim/cockpit/radios/com1_freq_hz")) / 100
r1_vhf_l_s = get(globalPropertyf("sim/cockpit/radios/com1_stdby_freq_hz")) / 100
r1_vhf_r_a = get(globalPropertyf("sim/cockpit/radios/com2_freq_hz")) / 100
r1_vhf_r_s = get(globalPropertyf("sim/cockpit/radios/com2_stdby_freq_hz")) / 100

xpndr_l_c = 4
xpndr_l_f = 5
xpndr_r_c = 0
xpndr_r_f = 0

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function r1_fine_u (phase)
    if phase == SASL_COMMAND_END then
        print "r1 fine u"
        c = ""
        if r1_mode == "vhf l" then
            c = r1_vhf_l_s 
        end
        if r1_mode == "vhf r" then
            c = r1_vhf_r_s 
        end
        v = round(c % 0.1 * 100)
        print (v .. " " .. c % 0.1 * 100 .. " " .. r1_vhf_l_s)

        if r1_mode == "vhf l" then
            if v == 0 or v == 10 or v == 5 then
                r1_vhf_l_s = r1_vhf_l_s + 0.02
            else
                r1_vhf_l_s = r1_vhf_l_s + 0.03
            end
        end
        if r1_mode == "vhf r" then
            if v == 0 or v == 10 or v == 5 then
                r1_vhf_r_s = r1_vhf_r_s + 0.02
            else
                r1_vhf_r_s = r1_vhf_r_s + 0.03
            end
        end

        r1_vhf_l_s = round(r1_vhf_l_s * 100) / 100
        r1_vhf_r_s = round(r1_vhf_r_s * 100) / 100

        if (r1_vhf_l_s > 137) or (r1_vhf_l_s == 137) then
            r1_vhf_l_s = r1_vhf_l_s - 19
        end
        if (r1_vhf_r_s > 137) or (r1_vhf_r_s == 137) then
            r1_vhf_r_s = r1_vhf_r_s - 19
        end

    end
end -- end r1_fine_u

function r1_fine_d (phase)
    if phase == SASL_COMMAND_END then
        print "r1 fine d"
        c = ""
        if r1_mode == "vhf l" then
            c = r1_vhf_l_s 
        end
        if r1_mode == "vhf r" then
            c = r1_vhf_r_s 
        end
        v = round(c % 0.1 * 100)
        print (v .. " " .. c % 0.1 * 100 .. " " .. r1_vhf_l_s)

        if r1_mode == "vhf l" then
            if v == 0 or v == 10 or v == 5 then
                r1_vhf_l_s = r1_vhf_l_s - 0.03
            else
                r1_vhf_l_s = r1_vhf_l_s - 0.02
            end
        end
        if r1_mode == "vhf r" then
            if v == 0 or v == 10 or v == 5 then
                r1_vhf_r_s = r1_vhf_r_s - 0.03
            else
                r1_vhf_r_s = r1_vhf_r_s - 0.02
            end
        end

        r1_vhf_l_s = round(r1_vhf_l_s * 100) / 100
        r1_vhf_r_s = round(r1_vhf_r_s * 100) / 100

        if (r1_vhf_l_s < 118) then
            r1_vhf_l_s = r1_vhf_l_s + 19
        end
        if (r1_vhf_r_s < 118) then
            r1_vhf_r_s = r1_vhf_r_s + 19
        end

    end
end -- end r1_fine_d

function r1_coarse_u (phase)
    if phase == SASL_COMMAND_END then
        print "r1 coarse u"
        if r1_mode == "vhf l" then
            r1_vhf_l_s = r1_vhf_l_s + 1
        end
        if r1_mode == "vhf r" then
            r1_vhf_r_s = r1_vhf_r_s + 1
        end

        r1_vhf_l_s = round(r1_vhf_l_s * 100) / 100
        r1_vhf_r_s = round(r1_vhf_r_s * 100) / 100

        if (r1_vhf_l_s > 137) or (r1_vhf_l_s == 137) then
            r1_vhf_l_s = r1_vhf_l_s - 19
        end
        if (r1_vhf_r_s > 137) or (r1_vhf_r_s == 137) then
            r1_vhf_r_s = r1_vhf_r_s - 19
        end
    end
end -- end r1_coarse_u

function r1_coarse_d (phase)
    if phase == SASL_COMMAND_END then
        print "r1 coarse d"
        if r1_mode == "vhf l" then
            r1_vhf_l_s = r1_vhf_l_s - 1
        end
        if r1_mode == "vhf r" then
            r1_vhf_r_s = r1_vhf_r_s - 1
        end

        r1_vhf_l_s = round(r1_vhf_l_s * 100) / 100
        r1_vhf_r_s = round(r1_vhf_r_s * 100) / 100

        if (r1_vhf_l_s < 118) then
            r1_vhf_l_s = r1_vhf_l_s + 19
        end
        if (r1_vhf_r_s < 118) then
            r1_vhf_r_s = r1_vhf_r_s + 19
        end
    end
end -- end r1_coarse_d
function r1_hf_t (phase)
    if phase == SASL_COMMAND_END then
        print "r1 hf t"
    end
end -- end r1_hf_t

function r_animate ()

end -- end fcs_animate

r1fu = sasl.createCommand("donut/panels/pedestal/radio1/fine_up", "")
r1fd = sasl.createCommand("donut/panels/pedestal/radio1/fine_down", "")
r1cu = sasl.createCommand("donut/panels/pedestal/radio1/coarse_up", "")
r1cd = sasl.createCommand("donut/panels/pedestal/radio1/coarse_down", "")
r1hf = sasl.createCommand("donut/panels/pedestal/radio1/hf_sense_toggle", "")
sasl.registerCommandHandler(r1fu , 0, r1_fine_u)
sasl.registerCommandHandler(r1fd , 0, r1_fine_d)
sasl.registerCommandHandler(r1cu , 0, r1_coarse_u)
sasl.registerCommandHandler(r1cd , 0, r1_coarse_d)
sasl.registerCommandHandler(r1hf , 0, r1_hf_t)


function r1_vhf_l (phase)
    if phase == SASL_COMMAND_END then
        print "r1 vhf l"
        r1_mode = "vhf l"
    end
end -- end r1_vhf_l

function r1_vhf_c (phase)
    if phase == SASL_COMMAND_END then
        print "r1 vhf c"
        r1_mode = "vhf c"
    end
end -- end r1_vhf_c

function r1_vhf_r (phase)
    if phase == SASL_COMMAND_END then
        print "r1 vhf r"
        r1_mode = "vhf r"
    end
end -- end r1_vhf_r

function r1_hf_l (phase)
    if phase == SASL_COMMAND_END then
        print "r1 hf l"
        r1_mode = "hf l"
    end
end -- end r1_hf_l

function r1_am (phase)
    if phase == SASL_COMMAND_END then
        print "r1 am"
        r1_mode = "am"
    end
end -- end r1_am

function r1_hf_r (phase)
    if phase == SASL_COMMAND_END then
        print "r1 hf r"
        r1_mode = "hf r"
    end
end -- end r1_hf_r

function r1_sw (phase)
    if phase == SASL_COMMAND_END then
        print "r1 sw"
        if r1_mode == "vhf l" then
            t = r1_vhf_l_s
            r1_vhf_l_s = r1_vhf_l_a
            r1_vhf_l_a = t
        end
        if r1_mode == "vhf r" then
            t = r1_vhf_r_s
            r1_vhf_r_s = r1_vhf_r_a
            r1_vhf_r_a = t
        end
    end
end -- end r1_sw

r1vhfl = sasl.createCommand("donut/panels/pedestal/radio1/vhf_l_push", "")
r1vhfc = sasl.createCommand("donut/panels/pedestal/radio1/vhf_c_push", "")
r1vhfr = sasl.createCommand("donut/panels/pedestal/radio1/vhf_r_push", "")
r1hfl = sasl.createCommand("donut/panels/pedestal/radio1/hf_l_push", "")
r1am = sasl.createCommand("donut/panels/pedestal/radio1/am_push", "")
r1hfr = sasl.createCommand("donut/panels/pedestal/radio1/hf_r_push", "")
r1sw = sasl.createCommand("donut/panels/pedestal/radio1/switch_push", "")

sasl.registerCommandHandler(r1vhfl , 0, r1_vhf_l)
sasl.registerCommandHandler(r1vhfc , 0, r1_vhf_c)
sasl.registerCommandHandler(r1vhfr , 0, r1_vhf_r)
sasl.registerCommandHandler(r1hfl , 0, r1_hf_l)
sasl.registerCommandHandler(r1am , 0, r1_am)
sasl.registerCommandHandler(r1hfr , 0, r1_hf_r)
sasl.registerCommandHandler(r1sw , 0, r1_sw)

function xpndr_l_fine_u (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr l fine u"
        xpndr_l_f = (xpndr_l_f + 1) % 8
    end
end -- end xpndr_l_fine_u

function xpndr_l_fine_d (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr l fine d"
        xpndr_l_f = (xpndr_l_f - 1) % 8

    end
end -- end xpndr_l_fine_d

function xpndr_l_coarse_u (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr l coarse u"
        xpndr_l_c = (xpndr_l_c + 1) % 8

    end
end -- end xpndr_l_coarse_u

function xpndr_l_coarse_d (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr l coarse d"
        xpndr_l_c = (xpndr_l_c - 1) % 8

    end
end -- end xpndr_l_coarse_d

function xpndr_r_fine_u (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr r fine u"
        xpndr_r_f = (xpndr_r_f + 1) % 8

    end
end -- end xpndr_r_fine_u

function xpndr_r_fine_d (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr r fine d"
        xpndr_r_f = (xpndr_r_f - 1) % 8

    end
end -- end xpndr_r_fine_d

function xpndr_r_coarse_u (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr r coarse u"
        xpndr_r_c = (xpndr_r_c + 1) % 8

    end
end -- end xpndr_r_coarse_u

function xpndr_r_coarse_d (phase)
    if phase == SASL_COMMAND_END then
        print "xpndr r coarse d"
        xpndr_r_c = (xpndr_r_c - 1) % 8

    end
end -- end xpndr_r_coarse_d

xpndrlcu = sasl.createCommand("donut/panels/pedestal/xpndr/l_coarse_up", "")
xpndrlcd = sasl.createCommand("donut/panels/pedestal/xpndr/l_coarse_down", "")
xpndrlfu = sasl.createCommand("donut/panels/pedestal/xpndr/l_fine_up", "")
xpndrlfd = sasl.createCommand("donut/panels/pedestal/xpndr/l_fine_down", "")

xpndrrcu = sasl.createCommand("donut/panels/pedestal/xpndr/r_coarse_up", "")
xpndrrcd = sasl.createCommand("donut/panels/pedestal/xpndr/r_coarse_down", "")
xpndrrfu = sasl.createCommand("donut/panels/pedestal/xpndr/r_fine_up", "")
xpndrrfd = sasl.createCommand("donut/panels/pedestal/xpndr/r_fine_down", "")

sasl.registerCommandHandler(xpndrlcu , 0, xpndr_l_coarse_u)
sasl.registerCommandHandler(xpndrlcd , 0, xpndr_l_coarse_d)
sasl.registerCommandHandler(xpndrlfu , 0, xpndr_l_fine_u)
sasl.registerCommandHandler(xpndrlfd , 0, xpndr_l_fine_d)
sasl.registerCommandHandler(xpndrrcu , 0, xpndr_r_coarse_u)
sasl.registerCommandHandler(xpndrrcd , 0, xpndr_r_coarse_d)
sasl.registerCommandHandler(xpndrrfu , 0, xpndr_r_fine_u)
sasl.registerCommandHandler(xpndrrfd , 0, xpndr_r_fine_d)

xpndmu = sasl.createCommand("donut/panels/pedestal/xpndr/mode_up", "")
xpndmd = sasl.createCommand("donut/panels/pedestal/xpndr/mode_down", "")
xpndident = sasl.createCommand("donut/panels/pedestal/xpndr/ident", "")

function setdigit (name, num)
    if num == 0 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 1)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 0)
        set(globalPropertyf(name .. "/5"), 1)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 1)
    end
    if num == 1 then
        set(globalPropertyf(name .. "/1"), 0)
        set(globalPropertyf(name .. "/2"), 0)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 0)
        set(globalPropertyf(name .. "/5"), 0)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 0)
    end
    if num == 2 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 0)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 1)
        set(globalPropertyf(name .. "/5"), 1)
        set(globalPropertyf(name .. "/6"), 0)
        set(globalPropertyf(name .. "/7"), 1)
    end
    if num == 3 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 0)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 1)
        set(globalPropertyf(name .. "/5"), 0)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 1)
    end
    if num == 4 then
        set(globalPropertyf(name .. "/1"), 0)
        set(globalPropertyf(name .. "/2"), 1)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 1)
        set(globalPropertyf(name .. "/5"), 0)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 0)
    end
    if num == 5 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 1)
        set(globalPropertyf(name .. "/3"), 0)
        set(globalPropertyf(name .. "/4"), 1)
        set(globalPropertyf(name .. "/5"), 0)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 1)
    end
    if num == 6 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 1)
        set(globalPropertyf(name .. "/3"), 0)
        set(globalPropertyf(name .. "/4"), 1)
        set(globalPropertyf(name .. "/5"), 1)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 1)
    end
    if num == 7 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 0)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 0)
        set(globalPropertyf(name .. "/5"), 0)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 0)
    end
    if num == 8 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 1)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 1)
        set(globalPropertyf(name .. "/5"), 1)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 1)
    end
    if num == 9 then
        set(globalPropertyf(name .. "/1"), 1)
        set(globalPropertyf(name .. "/2"), 1)
        set(globalPropertyf(name .. "/3"), 1)
        set(globalPropertyf(name .. "/4"), 1)
        set(globalPropertyf(name .. "/5"), 0)
        set(globalPropertyf(name .. "/6"), 1)
        set(globalPropertyf(name .. "/7"), 0)
    end
end

function setdigits (name, digits, num)
    for i = 0, digits - 1, 1 do
        setdigit(name .. "/" .. digits - (i), math.floor(num / math.pow(10, i)) % 10)
    end
end

function update ()
    set(globalPropertyf("donut/panels/pedestal/panel1/radio/dual"), 0)
    set(globalPropertyf("sim/cockpit/radios/com1_freq_hz"), r1_vhf_l_a * 100)
    set(globalPropertyf("sim/cockpit/radios/com2_freq_hz"), r1_vhf_r_a * 100)
    set(globalPropertyf("sim/cockpit/radios/transponder_code"), xpndr_l_c * 1000 + xpndr_l_f * 100 + xpndr_r_c * 10 + xpndr_r_f)
    if (r1_mode == "vhf l") then
        setdigits("donut/digits/radio1/a", 6, r1_vhf_l_a * 1000)
        setdigits("donut/digits/radio1/s", 6, r1_vhf_l_s * 1000)
    end
    if (r1_mode == "vhf r") then
        setdigits("donut/digits/radio1/a", 6, r1_vhf_r_a * 1000)
        setdigits("donut/digits/radio1/s", 6, r1_vhf_r_s * 1000)
    end

    setdigit("donut/digits/xpndr/1", xpndr_l_c)
    setdigit("donut/digits/xpndr/2", xpndr_l_f)
    setdigit("donut/digits/xpndr/3", xpndr_r_c)
    setdigit("donut/digits/xpndr/4", xpndr_r_f)


end -- end update

