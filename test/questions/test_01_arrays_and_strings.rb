require 'minitest/autorun'

describe <<-Q do
Implement an algorithm to determine if a string has all unique characters.
What if you cannot use additional data structures?
Q
  before do
    @uniq = 'qwertyuiop'
    @dups = 'jonathan'
  end
  # For big O, `l` is the length of the string.
  # Best concievable runtime is O(l) because we have to look at every character
  # in the string.

  describe 'without additional data structures' do
    # Bit vector solution best explained here: https://stackoverflow.com/a/12811293/2197402
    # ('a'..'z').map{|c| (1 << (c.ord - 'a'.ord)).to_s(2) }
    # Runtime: O(l) due to looping through chars
    # Space: No new structures created
    def uniq?(str)
      # Big "vector" of zeroes
      bit_vector = 0
      i = 0
      while i < str.length
        # Map each character to a 1 bit somewhere in a big "vector" of zeroes
        bit = 1 << (str[i].ord)
        # See if our vector already has that bit set to 1
        # If so, it's a dupe!
        return false if (bit_vector & bit) > 0
        # Otherwise, set that bit to 1
        bit_vector |= bit
        i += 1
      end
      true
    end

    it 'works with a bit vector' do
      uniq?(@uniq).must_equal(true)
      uniq?(@dups).must_equal(false)
    end
  end

  describe 'with a hash table' do
    # Runtime: O(l) due to looping through array of chars
    # Space: we made an new array of size l, and we made a hash table
    def uniq?(str)
      # string to list: O(l)
      # iterate list: O(l)
      # read and write to hash table: O(1)
      str.chars.each_with_object({}) do |index, object|
        return false if object.key?(str[index])
        object[str[index]] = 0
      end
      true
    end

    it 'works' do
      uniq?(@uniq).must_equal(true)
      uniq?(@dups).must_equal(false)
    end
  end

  describe 'with lists' do
    # Runtime: O(l log l) due to sort cost
    # Space: we made an new array of size l
    def uniq?(str)
      # transform string to list chars: O(l)
      chars = str.chars
      # in-place sort the list: O(l log l)
      sorted = chars.sort!
      # scan the list by pairs, looking for matches: O(l)
      contains_dups = sorted.each_cons(2).any? { |(l, r)| l == r }
      !contains_dups
    end

    it 'works' do
      uniq?(@uniq).must_equal(true)
      uniq?(@dups).must_equal(false)
    end
  end
end
