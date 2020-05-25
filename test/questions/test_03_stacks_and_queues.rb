require 'minitest/autorun'

describe <<-Q do
How would you design a stack which, in addition to push and pop, has a function
min which returns the minimum element? Push, pop, and min sould all operate in
O(1) time.
Q

  class Stack
    def initialize
      @stack = []
    end

    def to_a
      stack.map { |n| [n.value, n.lowest_seen] }
    end

    def peek
      stack.last
    end

    def push(value)
      current_min = min || value
      current_min = current_min <= value ? current_min : value
      stack.push(Node.new(value, current_min))
    end

    def pop
      stack.pop.value
    end

    def min
      peek&.lowest_seen
    end

    private

    attr_reader :stack

    Node = Struct.new(:value, :lowest_seen)
  end

  before { @numbers = [4, 6, 7, 7, 2, 4, 3, 9, 9, 6] }

  describe '#min' do
    it 'works' do
      stack = Stack.new
      @numbers.each do |number|
        stack.push(number)
      end
      stack.min.must_equal(2)
      until (popped = stack.pop) == 2; end
      stack.min.must_equal(4)
    end
  end
end
