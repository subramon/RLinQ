local S = {}
S.rain = { 
  { to = "rain", p = 0.3}, 
  { to = "nice", p = 0.7}, 
  { to = "snow", p = 0.0}, 
} 
S.nice = { 
  { to = "rain", p = 0.2}, 
  { to = "nice", p = 0.5}, 
  { to = "snow", p = 0.3}, 
}
S.snow = { 
  { to = "rain", p = 0.4}, 
  { to = "nice", p = 0.0}, 
  { to = "snow", p = 0.6}, 
} 
return S
