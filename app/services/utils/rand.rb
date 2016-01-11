module Utils
  class Rand
    # `n` random numbers in the given range without repeats
    def self.rand_n(n, range)
      randoms = Set.new
      loop do
        randoms << Random.rand(range)
        return randoms.to_a if randoms.size >= n
      end
    end
  end
end
