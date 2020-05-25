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
      seen << value
      queue << left if left
      queue << right if right
      to_see = queue.shift
      to_see ? to_see.breadth_first_traverse(queue, seen) : seen
    end

    def depth_first_traverse(stack = [], seen = [])
      seen << value
      stack.push(right) if right
      stack.push(left) if left
      to_see = stack.pop
      to_see ? to_see.depth_first_traverse(stack, seen) : seen
    end
  end
end

