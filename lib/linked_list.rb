class SinglyLinkedList
  attr_accessor :value, :tail

  def initialize(value:, tail: nil)
    self.value = value
    self.tail = tail
  end

  def tail=(value)
    @tail = self.class.from(value)
  end

  include Enumerable

  def each
    n = self
    while n
      yield n
      n = n.tail
    end
    n
  end

  # from (HEAD) 1 -> 2 -> 3 -> 4 -> 5 -> 6
  # to   (HEAD) 6 -> 5 -> 4 -> 3 -> 2 -> 1
  def reverse
    reduce(nil) do |left, right|
      self.class.new(value: right.value, tail: left)
    end
  end

  def delete(given_value)
    if value == given_value
      tail
    else
      self.tail = tail&.delete(given_value)
      self
    end
  end

  def self.from(x)
    return nil if x.nil?
    return x if x.class == self

    new(value: x)
  end

  # from     [  1 ,  2 ,  3 ,  4 ,  5 ,  6 ]
  # to   (HEAD) 1 -> 2 -> 3 -> 4 -> 5 -> 6
  def self.from_a(array)
    return unless array.any?

    head, *tail = array
    node_head = new(value: head)
    tail.reduce(node_head, &:tail=)
    node_head
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
