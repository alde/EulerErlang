class Primes
  # Generate a list of primes from 2 to the supplied limit.
  # Iterative and very slow.
  #
  # Params:
  # +limit+:: upper limit of primes. Last one will be <= this.
  def Primes.generatePrimes limit
    s = (2..limit)
    s.select { |num| (2..Math.sqrt(num)).none? {|d| (num % d).zero? }}
  end

  # Generate a list of primes from 2 to the supplied limit.
  # Uses the sieve of eratosthenes, very fast.
  #
  # Params:
  # +limit+:: upper limit of primes. Last one will be <= this.
  def Primes.generate limit
    s = (0..limit).to_a
    s[0] = s[1] = nil
    s.each do |p|
      next unless p
      break if p * p > limit
      (p*p).step(limit, p) { |m| s[m] = nil }
    end
    s.compact
  end

  # Check if it is a cyclic prime.
  def Primes.cyclic? number
    f = number.to_s
    i = f.length
    i.times do
      return false if prime?(f.to_i) == false
      f = Primes.rotate(f)
    end
    return true
  end

  # Check if the supplied value is a prime.
  #
  # Params:
  # +num+:: the number to check
  #
  # Return:
  # Boolean
  def Primes.prime? num
    if num < 2
      return false
    elsif num < 4
      return true
    elsif num % 2 == 0
      return false
    elsif num < 9
      return true
    elsif num % 3 == 0
      return false
    else
      r = (num**0.5).floor
      f = 5
      f.step r,6 do |g|
        if num % g == 0
          return false
        end
        if num % (g + 2) == 0
          return false
        end
      end
      return true
    end
  end

  protected

  # Rotate the given string
  #
  # Params:
  # +string+:: string to rotate
  #
  # Return:
  # String
  def Primes.rotate string
    steps = 1 % string.length
    string[-steps..-1].concat string[0...-steps]
  end

end