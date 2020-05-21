require 'minitest/autorun'
require 'linked_list'

describe LinkedList do
  describe '#push' do
    it 'adds data' do
      (0..9).each_with_object(LinkedList.new) do |v, l|
        l.push(v)
      end.to_a.must_equal(
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
      list.to_a.must_equal(
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
      @list.find(4)&.value.must_equal(4)
    end

    it 'accepts a block' do
      @list.find { |n| n.value == 4 }&.value.must_equal(4)
    end

    it 'returns nil if it does not exist' do
      assert_nil(@list.find(11))
    end
  end
end
