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

# https://www.rubyguides.com/2017/08/ruby-linked-list/
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

  def delete(value)
    return pop if head.value == value

    each_cons(3) do |a,b,c|
      b.next = nil if c.value == value
      a.next = c if b.value == value
    end
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

  class Node
    attr_reader :value
    attr_accessor :next

    def initialize(value)
      @value = value
    end
  end
end

class DoublyLinkedList
  attr_reader :value
  attr_accessor :child
  attr_accessor :parent

  def initialize(value:, parent: nil)
    @value = value
    @parent = parent
  end

  include Enumerable

  def each
    n = self
    while n
      yield n
      n = n.parent
    end
  end

  def to_a
    super.reverse
  end

  def <<(value)
    self.child = self.class.new(value: value, parent: self)
  end
end
