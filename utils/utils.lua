local LuaSF = require 'LuaSF'

local utils = {}

utils.coin_toss_rv = function(p)
  assert(type(p) == "number")
  assert((p >= 0) and (p <=1))
  local rv = LuaSF.binomialVA(999, p)
  if ( rv <= 499 ) then
    return "heads"
  else
    return "tails"
  end
end

return utils
