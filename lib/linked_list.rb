# https://www.rubyguides.com/2017/08/ruby-linked-list/

class Node
  attr_reader :value
  attr_accessor :next

  def initialize(value)
    @value = value
  end
end


# https://robots.thoughtbot.com/functional-ciphers-in-ruby

# Iterate :: a -> (a -> a) -> [a]
module Iterate
  def self.call(x, &block)
    Enumerator.new do |yielder|
      loop do
        yielder.yield(x)
        x = block.call(x)
      end
    end.lazy
  end
end

class LinkedList
  def initialize(head = nil)
    @head = head
  end

  def push(value)
    new_node = Node.new(value)
    new_node.next = head
    self.head = new_node
  end

  def pop
    popped = head
    self.head = popped.next
    popped.value
  end

  # Include Enumerable and implement #each so to automatically
  # have all of its methods
  # NB: Mine is lazy!
  # https://blog.appsignal.com/2018/05/29/ruby-magic-enumerable-and-enumerator.html
  include Enumerable

  def each(&blk)
    block_given? ? to_enum.each(&blk) : to_enum
  end

  private

  attr_accessor :head

  def to_enum
    Iterate.call(head) { |n| n&.next }.take_while(&:itself)
  end
end
