# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
#
# Find the sum of all numbers, less than one million, which are palindromic
# in base 10 and base 2.
#
# (Please note that the palindromic number, in either base, may not
# include leading zeros.)

class Euler036

    @@limit = 0
    @@list = 0
    def initialize limit=1000000
        @@limit = limit
        @@list = (1..limit).to_a
        printf(
            "=== Euler 036 ============= \n"
        )
    end

    def solve
        start = Time.now
        a = 0
        @@list.each do |x|
            a += x if palindrome? x.to_s and palindrome? binary x
        end
        stop = Time.now
        printf(
            "The sum of all doubly palindrome numbers under %d is: %d (%.4f ms.)\n",
            @@limit,
            a,
            ((stop - start) * 1000)
        )
    end

    def binary number
        number.to_s 2
    end

    def palindrome? number
        reverse = number.reverse #to not do the reversal twice, cuts time with 50%
        return true if number == reverse and reverse[0] != 0
        return false
    end

end

Euler036.new.solve