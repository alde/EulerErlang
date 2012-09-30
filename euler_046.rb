#!/bin/env ruby
require "prime"
(9..1/0.0).each{|i|
  next if (i%2==0 || i.prime?)
  1.step(i){|j|
    if 2*j**2 > i then p i; exit end
    break if (i-2*j**2).prime?
  }
}