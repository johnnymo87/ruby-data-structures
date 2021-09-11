require 'minitest/autorun'

# Problem01: A child is running up a staircase with n steps and can hop either
# 1 step, 2 steps, or 3 steps at a time. Implement a method to count how many
# possible ways the child can run up the stairs.

describe 'problem01' do
  # module Staircase
  #   def self.how_many_ways(number_of_steps)
  #     abc([[1] * number_of_steps]).tap do |x|
  #       require 'pry'; ::Kernel.binding.pry
  #     end.size
  #   end

  #   def self.abc(lists)
  #     lefts = left_fold(lists)
  #     rights = right_fold(lists)
  #     require 'pry'; ::Kernel.binding.pry
  #     (lefts.map(&:sort) | rights.map(&:sort)).sort
  #   end

  #   def self.left_fold(lists)
  #     head_list, *tail_lists = lists
  #     one, two, *rest = head_list
  #     return lists unless one && two
  #     return lists unless one + two < 5

  #     left_fold([[one + two] + rest, head_list] + tail_lists)
  #   end

  #   def self.right_fold(lists)
  #     head_list, *tail_lists = lists
  #     one, two, *rest = head_list
  #     return lists unless one && two
  #     return lists unless one + two < 5

  #     right_fold([rest + [one + two], head_list] + tail_lists)
  #   end
  # end

  # describe 'zero steps' do
  #   it 'zero ways' do
  #     Staircase.how_many_ways(0).must_equal(1)
  #   end
  # end

  # describe 'one step' do
  #   it 'one way' do
  #     Staircase.how_many_ways(1).must_equal(1)
  #   end
  # end

  # describe 'two steps' do
  #   it 'two ways' do
  #     Staircase.how_many_ways(2).must_equal(2)
  #   end
  # end

  # describe 'three steps' do
  #   it 'three ways' do
  #     Staircase.how_many_ways(3).must_equal(3)
  #   end
  # end

  # describe 'four steps' do
  #   it 'five ways' do
  #     Staircase.how_many_ways(4).must_equal(5)
  #   end
  # end

  # describe 'five steps' do
  #   it 'six ways' do
  #     Staircase.how_many_ways(5).must_equal(6)
  #   end
  # end

  # describe '10 steps' do
  #   it '11 ways' do
  #     Staircase.how_many_ways(10).must_equal(11)
  #   end
  # end
end

describe 'problem01' do
  module TopDownCombinations
    def self.how_many_ways(amount)
      coins = (1..([amount, 3].min)).to_a
      make_change(amount, coins, {})
    end

    private

    def self.make_change(amount, coins, memo)
      return 1 if amount == 0
      return 0 if amount < 0
      return 0 if coins.none?

      # puts "finding ways to get #{amount} with #{coins}"
      *fewer_coins, biggest_coin = coins
      smaller_amount = amount - biggest_coin

      (
        memo[[amount, fewer_coins]] ||= make_change(
          amount,
          fewer_coins,
          memo
        )
      ) + (
        memo[[smaller_amount, coins]] ||= make_change(
          smaller_amount,
          coins,
          memo
        )
      )
    end
  end

  describe '0 steps' do
    it '1 ways' do
      TopDownCombinations.how_many_ways(0).must_equal(1)
    end
  end

  describe '1 step' do
    it '1 way' do
      TopDownCombinations.how_many_ways(1).must_equal(1)
    end
  end

  describe '2 steps' do
    it '2 ways' do
      TopDownCombinations.how_many_ways(2).must_equal(2)
    end
  end

  describe '3 steps' do
    it '3 ways' do
      TopDownCombinations.how_many_ways(3).must_equal(3)
    end
  end

  describe '4 steps' do
    it '5 ways' do
      TopDownCombinations.how_many_ways(4).must_equal(4)
    end
  end

  describe '5 steps' do
    it '6 ways' do
      TopDownCombinations.how_many_ways(5).must_equal(5)
    end
  end

  describe '10 steps' do
    it '14 ways' do
      TopDownCombinations.how_many_ways(10).must_equal(14)
    end
  end
end

describe 'problem01' do
  module BruteForcePermutations
    def self.how_many_ways(number_of_steps)
      lists = [[1] * number_of_steps]
      (lists + abc(lists)).uniq.tap do |x|
        # require 'pry'; ::Kernel.binding.pry
      end.size
    end

    def self.abc(lists)
      reduced = lists.flat_map do |list|
        (0...list.size).each_cons(2).map do |left, right|
          l = list.clone
          if ((sum = l[left..right].sum) <= 3)
            l[left] = sum
            l.delete_at(right)
          end
          l
        end
      end.uniq
      if reduced == lists
        lists
      else
        reduced + abc(reduced)
      end
    end
  end

  describe '0 steps' do
    it '0 ways' do
      BruteForcePermutations.how_many_ways(0).must_equal(1)
    end
  end

  describe '1 step' do
    it '1 way' do
      BruteForcePermutations.how_many_ways(1).must_equal(1)
    end
  end

  describe '2 steps' do
    it '2 ways' do
      BruteForcePermutations.how_many_ways(2).must_equal(2)
    end
  end

  describe '3 steps' do
    it '4 ways' do
      BruteForcePermutations.how_many_ways(3).must_equal(4)
    end
  end

  describe '4 steps' do
    it '8 ways' do
      BruteForcePermutations.how_many_ways(4).must_equal(7)
    end
  end

  describe '5 steps' do
    it '15 ways' do
      BruteForcePermutations.how_many_ways(5).must_equal(13)
    end
  end

  describe '10 steps' do
    it '401 ways' do
      BruteForcePermutations.how_many_ways(10).must_equal(274)
    end
  end
end

describe 'problem01' do
  module BookSolution
    def self.count_ways(steps, memo = {})
      return 0 if steps < 0
      return 1 if steps == 0

      memo[steps] ||= (
        memo[steps - 1] ||= count_ways(steps - 1, memo)
      ) + (
        memo[steps - 2] ||= count_ways(steps - 2, memo)
      ) + (
        memo[steps - 3] ||= count_ways(steps - 3, memo)
      )
    end
  end

  describe '0 steps' do
    it '0 ways' do
      BookSolution.count_ways(0).must_equal(1)
    end
  end

  describe '1 step' do
    it '1 way' do
      BookSolution.count_ways(1).must_equal(1)
    end
  end

  describe '2 steps' do
    it '1 way' do
      BookSolution.count_ways(2).must_equal(2)
    end
  end

  describe '3 steps' do
    it '4 ways' do
      BookSolution.count_ways(3).must_equal(4)
    end
  end

  describe '4 steps' do
    it '8 ways' do
      BookSolution.count_ways(4).must_equal(7)
    end
  end

  describe '5 steps' do
    it '7 ways' do
      BookSolution.count_ways(5).must_equal(13)
    end
  end

  describe '10 steps' do
    it '149 ways' do
      BookSolution.count_ways(10).must_equal(274)
    end
  end
end
