local utils = require 'utils'
local T = require 'inputs_3_2'

local state = {}
state.Xt = T.X0 -- initial value 
state.Xt_prev = nil

for i = 1, T.time_steps do 
  state.Xt_prev = state.Xt
  local p
  if ( i == 1 ) then 
    p = 0.5
  else
    p = 0.5 * (1 - (T.alpha2 * (state.Xt - state.Xt_prev)))
  end
  local coin_toss = utils.coin_toss_rv(0.5)
  if ( coin_toss == "heads" ) then 
    state.Xt = state.Xt - 1
  else
    state.Xt = state.Xt + 1 
  end
  print(i, state.Xt)
end
return state
