require "./primes.rb"

# The number 3797 has an interesting property. Being prime itself, it is
# possible to continuously remove digits from left to right, and remain
# prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
# right to left: 3797, 379, 37, and 3.
#
# Find the sum of the only eleven primes that are both truncatable from left
# to right and right to left.
#
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

class Euler_037

    def initialize
        printf(
            "=== Euler 037 ============= \n"
        )
    end

    def solve
        start = Time.now
        primes = Primes.generate 1000000
        answer = truncatable primes
        stop = Time.now
        printf(
            "The sum of all 11 truncatable primes is: %d (%.4f ms.)\n",
            answer,
            ((stop - start) * 1000)
        )
    end

    def truncatable list
        count = 0
        answer = 0
        list.each do |x|
            next if x < 10
            break if count == 11
            if truncatable_prime? x
                count += 1
                answer += x
            end
        end
        return answer
    end

    def truncatable_prime? i
        nums = i.to_s.chars.to_a
        nums.length.times do
            return false if (!Primes.prime? nums.join().to_i)
            nums.shift
        end

        nums = i.to_s
        while nums.length > 0
            return false if (!Primes.prime? nums.to_i)
            nums.chop!()
        end
        return true
    end
end


Euler_037.new.solve