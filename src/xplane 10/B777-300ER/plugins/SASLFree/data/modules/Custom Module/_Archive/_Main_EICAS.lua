 -- _Main_EICAS.lua --
-- Chai11 Boeing 777-00ER     1-06-018

-- Script Version   0.0.1
-- Aircraft Version 0.40.0

local alphabet = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "wa","wb","wc","wd","we","wf","wg","ra", "rb", "rc"}

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
local outInt = 0

for i = ((column - 1) * 6) + 1, (string.len(str) - ((column - 1) * 6)) % 6, 1 do

        buffer = str:sub (i, i)
        local alphabet = (set == 1) and alphabet1 or (((set == 2) and alphabet2) or alphabet3)
        outInt = outInt + (alphabet[buffer] or 0) * math.pow(10, 6 - i) --does alphabet contain the substring? If so, change it to int

end

return outInt / 1000000 --must return as an float
end -- end StrToInt

for i = 1, 11, 1 do -- defines EICAS datarefs (189)

set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/a"), StrToFloat("hello", 1, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/b"), StrToFloat("hello", 2, 1))
set(globalPropertyf("donut/eicas/" .. alphabet[i] .. "/c"), StrToFloat("hello", 3, 1))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/a"), StrToFloat("hello", 1, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/b"), StrToFloat("hello", 2, 2))
set(globalPropertyf("donut/eicas2/" .. alphabet[i] .. "/c"), StrToFloat("hello", 3, 2))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/a"), StrToFloat("hello", 1, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/b"), StrToFloat("hello", 2, 3))
set(globalPropertyf("donut/eicas3/" .. alphabet[i] .. "/c"), StrToFloat("hello", 3, 1))

end -- end for loop
