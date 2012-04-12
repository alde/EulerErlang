# Take the number 192 and multiply it by each of 1, 2, and 3:
#
# 192 x 1 = 192
# 192 x 2 = 384
# 192 x 3 = 576
#
# By concatenating each product we get the 1 to 9 pandigital, 192384576.
# We will call 192384576 the concatenated product of 192 and (1,2,3)
#
# The same can be achieved by starting with 9 and multiplying by
# 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the
# concatenated product of 9 and (1,2,3,4,5).

# What is the largest 1 to 9 pandigital 9-digit number that can be formed as
# the concatenated product of an integer with (1,2, ... , n) where n > 1?

class Euler038
    def initialize
        puts "=== Euler 038 ============="
    end

    def solve
        start = Time.now
        largest = self.pandigital
        stop = Time.now
        printf(
            "The largest pandigital is: %d (%.4f ms.)\n",
            largest,
            ((stop-start)*1000)
        )
    end

    def pandigital
        max = 0
        (1..99999).each do |a|
            s = ""
            (1..9).each do |b|
                s += (a*b).to_s
                if s.length == 9 and s.split(//).sort.join == "123456789"
                    max = s.to_i if s.to_i > max
                elsif s.length > 9
                    break
                end
            end
        end
        return max
    end
end

Euler038.new.solve