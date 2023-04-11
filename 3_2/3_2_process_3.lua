-- TODO local cutils = require 'libcutils'
local utils  = require 'utils'
local LuaSF  = require 'LuaSF'
local T      = require 'inputs_3_2'

local state = {}
state.Ut = 0
state.Dt = 0

-- TODO local seed = cutils.RDTSC()
local alpha = T.alpha3
for i = 1, T.time_steps do 
  state.Xt_prev = state.Xt
  local Dt = state.Dt
  local Ut = state.Ut
  -- print("i, Dt/Ut = ", i, Dt, Ut)
  if ( ( Ut == 0 ) and ( Dt == 0 ) ) then 
    p_up   = 0.5 
    p_down = 0.5
    p_same = 0   
  else
    p_up   =  Dt/(Dt  + (alpha  * Ut))
    p_down =  Ut/(Ut  + (alpha  * Dt))
    p_same = 1 - (p_up + p_down)
  end
  -- TODO urv = cutils.uniform_rv(seed, 0, 1); 
  urv = LuaSF.unifVA(0, 1)
  if ( urv < p_up ) then 
    state.Ut = Ut + 1 
  elseif ( urv < p_up + p_down ) then
    state.Dt = Dt + 1 
  else
    -- TODO P2 Argue why this case does not happen
    -- print("no change")
  end
  -- print(i, T.X0 + (state.Ut-state.Dt))
end
print("Final value = ", T.X0 + (state.Ut-state.Dt))
return state
