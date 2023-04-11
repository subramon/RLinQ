local utils = require 'utils'
local T = require 'inputs_3_2_process_1'

local X = T.X0 -- initial value 

for i = 1, T.time_steps do 
  local p = 1.0/(1 + math.exp(-1.0 * T.alpha1 * (T.L - X)))
  assert(p >= 0)
  local coin_toss = utils.coin_toss_rv(p)
  if ( coin_toss == "heads" ) then 
    X = X - 1
  else
    X = X + 1 
  end
end
return X
