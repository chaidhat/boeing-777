size = {400,640}  

font1 = sasl.gl.loadFont(moduleDirectory.."/configuration/widgetResources/Bfont-Regular.ttf")
font2 = sasl.gl.loadFont(moduleDirectory.."/configuration/widgetResources/dosis.medium.ttf")
font3 = sasl.gl.loadFont(moduleDirectory.."/configuration/widgetResources/dosis.bold.ttf")

--addSearchPath(moduleDirectory.."/configuration/widgetResources/")

function co (str)
	s = "  "
	for j = 1, string.len(str), 1 do
		s = s .. string.upper(str:sub(j, j)) .. " "
	end
	return s
end

function by (str)
	s = ""
	for j = 1, string.len(str), 1 do
		s = s .. string.char(string.byte(str, j) % 128)
	end
	return s
end

function form (str, s)
	k = 0
	if not(str:len() == 2) then
	while not (str:sub(k, k) == ",") do
		k = k + 1
		if k > 100 then
			break
		end
	end
	k = k + 1
	while not (str:sub(k, k) == ",") do
		k = k + 1
		if k > 100 then
			break
		end
	end
	k = k + 1
	l = 0
	while not (str:sub(l, l) == ";") do
		l = l + 1
		if l > 100 then
			break
		end
	end
	l = l - 1
	m = k + 2
	while not (str:sub(m, m) == ",") do
		m = m + 1
		if m > 100 then
			break
		end
	end
	m = m + 1
	while not (str:sub(m, m) == ",") do
		m = m + 1
		if m > 100 then
			break
		end
	end
	m = m + 1
	n = l + 2
	while not (str:sub(n, n) == ";") do
		n = n + 1
		if n > 100 then
			break
		end
	end
	n = n - 1
	if (s) then
	return str:sub(k, l)
	end
	if (not s) then
	return str:sub(m, n)
	end
end
return " "

end

function draw () 

	drawAll(components)

jr = 1
j = 1
b = 1

for i = 1, 11, 1 do -- allocates messages

b = i
buffer = ""
buffer_r = ""
buffer_w = ""

if (not (get(globalPropertys("donut/eicasmsg/" .. jr .. "/r")) == "")) and b == i then

buffer = ""
buffer_r = get(globalPropertys("donut/eicasmsg/" .. jr .. "/r"))
buffer_w = ""
jr = jr + 1
b = i + 1

end
if (not (get(globalPropertys("donut/eicasmsg/" .. j)) == "")) and b == i then

--if (get(globalPropertys("donut/eicasmsg/" .. j)):sub (1,1) == " ") then
buffer = get(globalPropertys("donut/eicasmsg/" .. j))
buffer_r = ""
buffer_w = ""
j = j + 1
b = i + 1
--end
--if not (get(globalPropertys("donut/eicasmsg/" .. j)):sub (1,1) == " ") then
--buffer = get(globalPropertys("donut/eicasmsg/" .. j))
--buffer_r = ""
--buffer_w = ""
--j = j + 1
--b = i + 1
--end
end
if (not (get(globalPropertys("donut/eicasmsg/" .. (12 - i) .. "/w")) == "")) and b == i then

buffer = ""
buffer_r = ""
buffer_w = get(globalPropertys("donut/eicasmsg/" .. (12 - i) .. "/w"))
b = i + 1

end



-- defines EICAS datarefs (189)
drawText(font1, 1310, 851 + (17 * (9 - i)), buffer, 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})

drawText(font1, 1310, 851 + (17 * (9 - i)), buffer_r, 15, false, false, TEXT_ALIGN_LEFT, {1, 0, 0})

drawText(font1, 1310, 851 + (17 * (9 - i)), buffer_w, 15, false, false, TEXT_ALIGN_LEFT, {1, 1, 1})

drawText(font1, 240, 940, get(globalPropertys("donut/pfd/fma/speed")), 30, false, false, TEXT_ALIGN_CENTER, {0, 0.75, 0})
drawText(font1, 430, 940, get(globalPropertys("donut/pfd/fma/lateral")), 30, false, false, TEXT_ALIGN_CENTER, {0, 0.75, 0})
drawText(font1, 630, 940, get(globalPropertys("donut/pfd/fma/vertical")), 30, false, false, TEXT_ALIGN_CENTER, {0, 0.75, 0})


end -- end for loop

j = 1
for i = 1, 6, 1 do 

if not get(globalPropertys("xfmc/Version")) then
	drawText(font2, 1270, 1200, "INSTALL X-FMC", 35, false, false, TEXT_ALIGN_CENTER, {1, 0, 0})
	drawText(font2, 1270, 1149, "https://www.x-fmc.com", 35, false, false, TEXT_ALIGN_CENTER, {1, 1, 1})
else
	drawText(font2, 1270, 1220, form(string.upper(get(globalPropertys("xfmc/Upper"))), 1), 35, false, false, TEXT_ALIGN_CENTER, {1, 1, 1})

	if (i < 4) then
	drawText(font2, 1050, 1185 - (51 * (i - 1)), co(form(by(get(globalPropertys("xfmc/Panel_" .. j + 1))), 1)), 24, false, false, TEXT_ALIGN_LEFT, {1, 1, 1})
	drawText(font2, 1050, 1157 - (51 * (i - 1)), form(string.upper(get(globalPropertys("xfmc/Panel_" .. j))), 1), 35, false, false, TEXT_ALIGN_LEFT, {1, 1, 1})

	drawText(font2, 1500, 1185 - (51 * (i - 1)), co(form(by(get(globalPropertys("xfmc/Panel_" .. j + 1))), false)), 24, false, false, TEXT_ALIGN_RIGHT, {1, 1, 1})
	drawText(font2, 1500, 1157 - (51 * (i - 1)), form(string.upper(get(globalPropertys("xfmc/Panel_" .. j))), false), 35, false, false, TEXT_ALIGN_RIGHT, {1, 1, 1})
	end

	if (i > 4) then

	drawText(font2, 1557, 1406 - (51 * (i - 1)), co(form(by(get(globalPropertys("xfmc/Panel_" .. j + 1))), 1)), 24, false, false, TEXT_ALIGN_LEFT, {1, 1, 1})
	drawText(font2, 1557, 1379 - (51 * (i - 1)), form(string.upper(get(globalPropertys("xfmc/Panel_" .. j))), 1), 35, false, false, TEXT_ALIGN_LEFT, {1, 1, 1})

	drawText(font2, 2007, 1406 - (51 * (i - 1)), co(form(by(get(globalPropertys("xfmc/Panel_" .. j + 1))), false)), 24, false, false, TEXT_ALIGN_RIGHT, {1, 1, 1})
	drawText(font2, 2007, 1379 - (51 * (i - 1)), form(string.upper(get(globalPropertys("xfmc/Panel_" .. j))), false), 35, false, false, TEXT_ALIGN_RIGHT, {1, 1, 1})

	drawText(font2, 1557, 1379 - (51 * 6), form(string.upper(get(globalPropertys("xfmc/Scratch"))), 1), 35, false, false, TEXT_ALIGN_LEFT, {1, 1, 1})
	end
end

j = j + 2
end
	
	--drawText(font1, 1310, 970, "", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	--drawText(font1, 1310, 953, " tcas", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	----drawText(font1, 1330, 953, " doors", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	--drawText(font1, 1310, 936, " tcas", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	--drawText(font1, 1310, 919, " tcas", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	--drawText(font1, 1310, 902, " tcas", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	--drawText(font1, 1310, 885, " tcas", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	--drawText(font1, 1310, 868, " tcas", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
	--drawText(font1, 1310, 851, " tcas", 15, false, false, TEXT_ALIGN_LEFT, {1, 0.75, 0})
end