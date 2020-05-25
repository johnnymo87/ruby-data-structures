require 'minitest/autorun'
require 'binary_tree'

describe BinaryTree do
  before { @numbers = [9, 4, 12, 15, 72, 21, 36, 2, 10, 14, 8, 19] }

  #                                9
  #                            /       \
  #                          4          12
  #                         /  \       /  \
  #                        2    8    10    15
  #                                       /  \
  #                                     14    72
  #                                          /
  #                                        21
  #                                       /  \
  #                                     19    36

  describe 'creating a tree' do
    describe '#insert' do
      it 'works' do
        head, *tail = @numbers
        root = BinaryTree::Node.new(head)
        tail.each { |number| root.insert(number) }
        root.value.must_equal(9)
        (left = root.left).value.must_equal(4)
        left.left.value.must_equal(2)
        left.right.value.must_equal(8)
        (right = root.right).value.must_equal(12)
        right.left.value.must_equal(10)
        (right = right.right).value.must_equal(15)
        right.left.value.must_equal(14)
        (right = right.right).value.must_equal(72)
        (left = right.left).value.must_equal(21)
        left.left.value.must_equal(19)
        left.right.value.must_equal(36)
      end
    end
  end

  describe 'working with existing trees' do
    before do
      head, *tail = @numbers
      @root = BinaryTree::Node.new(head)
      tail.each { |number| @root.insert(number) }
    end

    describe '#breadth_first_traverse' do
      it 'works' do
        traversed = @root.breadth_first_traverse
        traversed.must_equal([9, 4, 12, 2, 8, 10, 15, 14, 72, 21, 19, 36])
      end
    end

    describe '#depth_first_traverse' do
      it 'works' do
        traversed = @root.depth_first_traverse
        traversed.must_equal([9, 4, 2, 8, 12, 10, 15, 14, 72, 21, 19, 36])
      end
    end
  end
end
