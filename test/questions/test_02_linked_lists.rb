require 'minitest/autorun'
require 'linked_list'

describe <<-Q do
Write Code to remove duplicates from an unsorted linked list.
How would you solve this problem if a temporary buffer is not allowed?
Q
  before do
    numbers = [4, 6, 7, 7, 2, 4, 3, 9, 9, 6]
    parent_value, *children_values = numbers
    @list = children_values.reduce(
      DoublyLinkedList.new(value: parent_value)
    ) do |parent, child_value|
      parent << child_value
    end
  end
  # For big O, `l` is the length of the list.
  # Best concievable runtime is O(l) because we have to look at every character
  # in the list.

  describe 'hash table' do
    # Runtime: O(l) iterate the list once
    # Space: new set (+1 O(l))
    def dedup(given_list)
      set = Set.new
      given_list.each do |node|
        if set.include?(node.value)
          node.parent&.child = node.child
          node.child&.parent = node.parent
        else
          set << node.value
        end
      end
      given_list
    end

    it 'works' do
      dedup(@list).to_a.map(&:value).must_equal(
        [7, 2, 4, 3, 9, 6]
      )
    end
  end

  describe 'nested loop' do
    # Runtime: O(l**2) iterate the rest of the list once for each element
    # Space: nothing new
    def dedup(given_list)
      given_list.each do |given_node|
        given_node.parent.each do |descendant_node|
          if given_node.value == descendant_node.value
            descendant_node.child&.parent = descendant_node.parent
            descendant_node.parent&.child = descendant_node.child
          end
        end
      end
      given_list
    end

    it 'works' do
      dedup(@list).to_a.map(&:value).must_equal(
        [7, 2, 4, 3, 9, 6]
      )
    end
  end
end
