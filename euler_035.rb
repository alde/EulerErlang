require './primes.rb'

#---- Description --------------------------------------------------------------
# The number, 197, is called a circular prime because all rotations
# of the digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100:
#   2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
#
# How many circular primes are there below one million?
#-------------------------------------------------------------------------------

class Euler35

  @@primes = nil

  def initialize
    @@primes = Primes.new
    printf(
      "=== Euler 035 ============= \n"
    )
  end
  # start solving
  #
  # Params:
  # +limit+:: upper limit, defaulted to 1000000
  def solve limit=1000000
    start = Time.now
    cyclic = getCyclic @@primes.sieveOfEratosthenes limit
    stop = Time.now
    printf(
      "Cyclic primes: %d (Time: %.4f ms.)\n",
      cyclic.length,
      ((stop - start) * 1000)
    )
  end

  # Filter out the cyclic primes.
  #
  # Return:
  # Array of cyclic primes.
  def getCyclic primes
    return primes.find_all { |b| @@primes.cyclic? b }
  end

end

Euler35.new.solve
