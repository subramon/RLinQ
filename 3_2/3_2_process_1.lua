local utils = require 'utils'
local T = require 'inputs_3_2'

local state = {}
state.Xt = T.X0 -- initial value 

for i = 1, T.time_steps do 
  local p = 1.0/(1 + math.exp(-1.0 * T.alpha1 * (T.L - state.Xt)))
  assert(p >= 0)
  local coin_toss = utils.coin_toss_rv(p)
  if ( coin_toss == "heads" ) then 
    state.Xt = state.Xt - 1
  else
    state.Xt = state.Xt + 1 
  end
  print(state.Xt)
end
return state
