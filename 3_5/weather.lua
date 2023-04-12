-- NOTE: Efficiency is the last thing we are looking for in this code
local S = require 'states'
local LuaSF = require 'LuaSF'
local function count_entries(S)
  local nS = 0
  for _, _ in pairs(S) do nS = nS + 1 end 
  return nS
end
--- calculate number of states
local nS = count_entries(S)

local function calc_next_state(S, w)
  local urv = LuaSF.unifVA(0, 1)
  local s = S[w]
  assert(type(s) == "table")
  local ns = #s
  assert(ns == nS)
  local cum_prob = 0
  for i = 1, ns do 
    local p = s[i].p
    assert((p >= 0) and (p <= 1.0))
    cum_prob = cum_prob + p
    assert((cum_prob >= 0) and (cum_prob <= 1.0))
    if ( urv < cum_prob ) then return s[i].to end
  end
  return nil -- error condition
end

w = "nice" -- initial state
local n_traces = 100 

local count = {} -- keeps tracks of how many times a weather state occurred
for i = 1, n_traces do 
  if ( not count[w] ) then count[w] = 1 else count[w] = count[w] + 1 end 
  w = calc_next_state(S, w)
  -- print("i: ", i, w)
end
for k, v in pairs(count) do print(k,v) end 
