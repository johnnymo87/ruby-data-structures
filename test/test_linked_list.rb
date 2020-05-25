require 'minitest/autorun'
require 'linked_list'

describe LinkedList do
  describe '#push' do
    it 'adds data' do
      (0..9).each_with_object(LinkedList.new) do |v, l|
        l.push(v)
      end.map(&:value).must_equal(
        (0..9).to_a.reverse
      )
    end
  end

  describe '#pop' do
    it 'removes the data last added' do
      list = (0..9).each_with_object(LinkedList.new) do |v, l|
        l.push(v)
      end
      list.pop.must_equal(9)
      list.map(&:value).must_equal(
        (0..8).to_a.reverse
      )
    end
  end

  describe '#find' do
    before do
      @list = (0..9).each_with_object(LinkedList.new) do |v, l|
        l.push(v)
      end
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
      @list = (0..9).each_with_object(LinkedList.new) do |v, l|
        l.push(v)
      end
    end

    it 'works' do
      @list.select { |n| n.value.odd? }.map(&:value).must_equal(
        (0..9).select(&:odd?).reverse
      )
    end
  end

  describe '#delete' do
    before do
      @list = (0..9).each_with_object(LinkedList.new) do |v, l|
        l.push(v)
      end
    end

    it 'can delete the first item of the list' do
      @list.delete(9)
      @list.map(&:value).must_equal(
        (0..9).to_a.reverse - [9]
      )
    end

    it 'can delete the second item of the list' do
      @list.delete(8)
      @list.map(&:value).must_equal(
        (0..9).to_a.reverse - [8]
      )
    end

    it 'can delete the third item of the list' do
      @list.delete(7)
      @list.map(&:value).must_equal(
        (0..9).to_a.reverse - [7]
      )
    end

    it 'can delete the fourth item of the list' do
      @list.delete(6)
      @list.map(&:value).must_equal(
        (0..9).to_a.reverse - [6]
      )
    end

    it 'can delete the last item of the list' do
      @list.delete(0)
      @list.map(&:value).must_equal(
        (0..9).to_a.reverse - [0]
      )
    end

    it 'does nothing if it does not exist' do
      @list.delete(-1)

      @list.map(&:value).must_equal(
        (0..9).to_a.reverse
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
      parent << child_value
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
