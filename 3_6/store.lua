local LuaSF = require 'LuaSF'

local C = 4 -- storage capacity
local s = {} -- state
s.alpha = 0 --- On Hand Inventory 
s.alpha_prev = 0 --- On Hand Inventory 
s.beta_prev  = 0 --- On Order Inventory (previous
s.beta  = 0 --- On Order Inventory 
local num_traces = 100
local lambda = 0.5 -- parameter of Poission distribution of demand 

-- number of possible states S is (C+1)*(C+1)
local nS = (C+1)*(C+1) --- number of states
-- we will maintain transition probabilities in a 2D array 
-- indexed by (alpha*(C+1) + beta)
local P = {}
for i = 1, nS+1 do 
  P[i] = {}
  for j = 1, nS+1 do 
    P[i][j] = 0
  end
end
-- N[i] contains the number of times we were at state i
local N = {}
for i = 1, nS+1 do 
  N[i] = 0
end

for i = 1, num_traces do 
  local from_sidx = (s.alpha_prev * (C+1)) + s.beta_prev
  assert((from_sidx>=0) and (from_sidx <=nS))
  from_sidx = from_sidx + 1 -- for Lua indexing

  local to_sidx = (s.alpha * (C+1)) + s.beta
  assert((to_sidx>=0) and (to_sidx <=nS))
  to_sidx = to_sidx + 1 -- for Lua indexing

  N[from_sidx] = N[from_sidx] + 1
  P[from_sidx][to_sidx]  = P[from_sidx][to_sidx] + 1
  -- observe the state  (6 pm)
  -- Order according to the ordering policy described above.
  local order = C - (s.alpha+s.beta)
  if ( order < 0 ) then order = 0 end 
  s.beta_prev = s.beta
  s.beta = order
  -- Receive bicycles at 6am if you had ordered 36 hours ago.
  local stock = s.alpha + s.beta_prev
  -- Experience random demand from customers 
  local demand = LuaSF.poissonVA(lambda)
  -- number of bicycles sold for the day will be the minimum of demand
  -- on the day and inventory at store opening on the day
  if ( demand > stock ) then demand = stock end
  -- Close the store at 6pm and observe the state (this state is St+1).
  s.alpha_prev = s.alpha
  s.alpha = stock - demand 
  print(i, s.alpha, s.beta, demand)
end
