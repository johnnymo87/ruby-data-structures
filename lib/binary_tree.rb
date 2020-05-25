module BinaryTree
  class Node
    attr_accessor :value, :left, :right

    def initialize(value, left = nil, right = nil)
      @value = value
      @left = left
      @right = right
    end

    def insert(given_value)
      if given_value >= value
        right ? right.insert(given_value) : self.right = self.class.new(given_value)
      else
        left ? left.insert(given_value) : self.left = self.class.new(given_value)
      end
    end

    def breadth_first_traverse(queue = [], seen = [])
      seen << self
      queue << left if left
      queue << right if right
      to_see = queue.shift
      to_see ? to_see.breadth_first_traverse(queue, seen) : seen
    end

    def depth_first_traverse(stack = [], seen = [])
      seen << self
      stack.push(right) if right
      stack.push(left) if left
      to_see = stack.pop
      to_see ? to_see.depth_first_traverse(stack, seen) : seen
    end

    def weight
      leaf? ? 1 : (left_weight + right_weight)
    end

    def level_of_imbalance
      left_weight - right_weight
    end

    def balanced?
      -1 <= level_of_imbalance && level_of_imbalance <= 1
    end

    private

    def left_weight
      left&.weight || 0
    end

    def right_weight
      right&.weight || 0
    end

    def leaf?
      !(left || right)
    end
  end
end
