LuaSF = require 'LuaSF'
-- START: Get the inputs 
assert(type(arg) == "table")

for k, v in pairs(arg) do print(k,v) end 
local X0 = assert(arg[1]) -- initial value 
X0 = assert(tonumber(X0))

local nT = assert(arg[2]) -- number of traces
nT = assert(tonumber(nT))
assert(nT >= 1)

local L = assert(arg[3]) -- arbitrary reference level
L = assert(tonumber(L))
assert(type(L) == "number")

local alpha1 = assert(arg[4]) -- "pull strength" parameter
print("alpha1 = ", alpha1)
alpha1 = assert(tonumber(alpha1))
print("alpha1 = ", alpha1)
assert(type(alpha1) == "number")
print("alpha1 = ", alpha1)
assert(alpha1 >= 0)
print("alpha1 = ", alpha1)

-- STOP : Get the inputs 

local X = X0 -- initial value 

for i = 1, nT do 
  local p = 1.0/(1.0 + math.exp(-1.0 * alpha1 * (L - X)))
  local rv = LuaSF.binomialVA(1000, p)
  print("rv = ", rv)
  if ( p < 500 ) then
    X = X + 1
  else
    X = X - 1 
  end
  print("p = ", p / 1000.0)
  print("X = ", X)
end
