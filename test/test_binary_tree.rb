require 'minitest/autorun'
require 'binary_tree'

describe BinaryTree do
  before { @numbers = [9, 4, 12, 15, 72, 21, 36, 2, 10, 14, 8, 19] }

  #                                9
  #                              /   \
  #                             /     \
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


  #     [9  , 4 , 2 , 8 , 12 , 10 , 15 , 14 , 72 , 21 , 19 , 36]
  #     [6  , 2 , 1 , 1 , 4  , 1  , 3  , 1  , 2  , 2  , 1  , 1]
  #     [-2 , 0 , 0 , 0 , -2 , 0  , -1 , 0  , 2  , 0  , 0  , 0]

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
        traversed = @root.breadth_first_traverse.map(&:value)
        traversed.must_equal([9, 4, 12, 2, 8, 10, 15, 14, 72, 21, 19, 36])
      end
    end

    describe '#depth_first_traverse' do
      it 'works' do
        traversed = @root.depth_first_traverse.map(&:value)
        traversed.must_equal([9, 4, 2, 8, 12, 10, 15, 14, 72, 21, 19, 36])
      end
    end

    describe '#weight' do
      it 'counts the number of leaves in descendants' do
        weights = @root.depth_first_traverse.map(&:weight)
        weights.must_equal([6, 2, 1, 1, 4, 1, 3, 1, 2, 2, 1, 1])
      end
    end

    describe '#level_of_imbalance' do
      it 'works' do
        levels = @root.depth_first_traverse.map(&:level_of_imbalance)
        levels.must_equal([-2, 0, 0, 0, -2, 0, -1, 0, 2, 0, 0, 0])
      end
    end
  end
end
