require 'minitest/autorun'
require 'linked_list'

describe SinglyLinkedList do
  describe '#from_a' do
    it 'builds a list in the same "direction"' do
      SinglyLinkedList.from_a((0..9).to_a).map(&:value).must_equal(
        (0..9).to_a
      )
    end
  end

  describe '#reverse' do
    before do
      @list = SinglyLinkedList.from_a((0..9).to_a)
    end

    it 'reverses' do
      @list.reverse.map(&:value).must_equal((0..9).to_a.reverse)
    end
  end

  describe '#find' do
    before do
      @list = SinglyLinkedList.from_a((0..9).to_a)
    end

    it 'returns the value if it exists' do
      @list.find { |n| n.value == 4 }&.value.must_equal(4)
    end

    it 'returns nil if it does not exist' do
      assert_nil(@list.find { |n| n.value == 11 })
    end
  end

  describe 'chaining enumerable methods' do
    before do
      @list = SinglyLinkedList.from_a((0..9).to_a)
    end

    it 'works' do
      @list.select { |n| n.value.odd? }.map(&:value).must_equal(
        (0..9).select(&:odd?)
      )
    end
  end

  describe '#delete' do
    before do
      @list = SinglyLinkedList.from_a((0..9).to_a)
    end

    it 'can delete the first item of the list' do
      @list.delete(0).map(&:value).must_equal(
        (0..9).to_a - [0]
      )
    end

    it 'can delete the last item of the list' do
      @list.delete(9).map(&:value).must_equal(
        (0..9).to_a - [9]
      )
    end

    it 'can delete an item in the middle of the list' do
      @list.delete(5).map(&:value).must_equal(
        (0..9).to_a - [5]
      )
    end

    it 'does nothing if it does not exist' do
      @list.delete(-1).map(&:value).must_equal(
        (0..9).to_a
      )
    end

    it 'removes only the first match from the list' do
      SinglyLinkedList.from_a(
        [4,5,4,5,4,5]
      ).delete(5).map(&:value).must_equal(
        [4,4,5,4,5]
      )
    end
  end
end

describe DoublyLinkedList do
  before do
    @numbers = [4, 6, 7, 7, 2, 4, 3, 9, 9, 6]
    parent_value, *children_values = @numbers
    @list = children_values.reduce(
      DoublyLinkedList.new(value: parent_value)
    ) do |parent, child_value|
      parent.prepend(child_value)
    end
  end

  describe '#to_a' do
    it 'works' do
      @list.to_a.map(&:value).must_equal(
        @numbers
      )
    end
  end
end
