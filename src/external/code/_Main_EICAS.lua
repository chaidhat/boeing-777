 -- _Main_EICAS.lua --
-- Chai112 Boeing 777-00ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0

local alphabet = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"}

function Set (list) --assumes length to be nine!
local set = {}
for m = 1, 9, 1 do --for the length of list
    set[list[m]] = m --each items reference is their name

end
return set
end

function StrToFloat (str, set, column)

local alphabet1 = Set {"a","b","c","d","e","f","g","h","i"}
local alphabet2 = Set {"j","k","l","m","n","o","p","q","r"}
local alphabet3 = Set {"s","t","u","v","w","x","y","z","+"}

local buffer
local buffer_r
local buffer_w
local outInt = 0
local offset = 0

if string.len(str) < (column * 6) + 1 then
offset = (column * 6) - string.len(str)
end
for i = ((column - 1) * 6) + 1, (column * 6) - offset, 1 do

        buffer = str:sub (i, i)
        local alphabet = (set == 1) and alphabet1 or (((set == 2) and alphabet2) or alphabet3)
        outInt = outInt + (alphabet[buffer] or 0) * math.pow(10, 6 - i + ((column - 1) * 6)) --does alphabet contain the substring? If so, change it to int

end

return outInt / 1000000 --must return as an float
end -- end StrToInt

function update ()

for i = 1, 11, 1 do -- allocates messages

buffer = ""
buffer_r = ""
buffer_w = ""

if (not (get(globalPropertys("donut/eicasmsg/" .. (i - 5) .. "/r")) == "") and i > 5 and i < 9) then
buffer = ""
buffer_r = get(globalPropertys("donut/eicasmsg/" .. (i - 5) .. "/r"))
buffer_w = ""

else
if not (get(globalPropertys("donut/eicasmsg/" .. 1)) == "") then

if not (get(globalPropertys("donut/eicasmsg/" .. i)):sub (1,1) == " ") then
buffer = get(globalPropertys("donut/eicasmsg/" .. i))
buffer_r = ""
buffer_w = ""

else
buffer = get(globalPropertys("donut/eicasmsg/" .. i))
buffer_r = ""
buffer_w = ""

end -- end y msg conditional
else
if not (get(globalPropertys("donut/eicasmsg/" .. (12 - i) .. "/w")) == "") and i > 5 then
buffer = ""
buffer_r = ""
buffer_w = get(globalPropertys("donut/eicasmsg/" .. (12 - i) .. "/w"))
end
end
end -- end if



-- defines EICAS datarefs (189)

set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/a"), StrToFloat(buffer, 1, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/b"), StrToFloat(buffer, 2, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/c"), StrToFloat(buffer, 3, 1))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/a"), StrToFloat(buffer, 1, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/b"), StrToFloat(buffer, 2, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/c"), StrToFloat(buffer, 3, 2))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/a"), StrToFloat(buffer, 1, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/b"), StrToFloat(buffer, 2, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/c"), StrToFloat(buffer, 3, 3))

if i > 5 then
if i < 9 then

set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/a/r"), StrToFloat(buffer_r, 1, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/b/r"), StrToFloat(buffer_r, 2, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/c/r"), StrToFloat(buffer_r, 3, 1))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/a/r"), StrToFloat(buffer_r, 1, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/b/r"), StrToFloat(buffer_r, 2, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/c/r"), StrToFloat(buffer_r, 3, 2))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/a/r"), StrToFloat(buffer_r, 1, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/b/r"), StrToFloat(buffer_r, 2, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/c/r"), StrToFloat(buffer_r, 3, 3))
end

set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/a/w"), StrToFloat(buffer_w, 1, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/b/w"), StrToFloat(buffer_w, 2, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/c/w"), StrToFloat(buffer_w, 3, 1))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/a/w"), StrToFloat(buffer_w, 1, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/b/w"), StrToFloat(buffer_w, 2, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/c/w"), StrToFloat(buffer_w, 3, 2))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/a/w"), StrToFloat(buffer_w, 1, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/b/w"), StrToFloat(buffer_w, 2, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/c/w"), StrToFloat(buffer_w, 3, 3))
end

end -- end for loop
end -- end update
