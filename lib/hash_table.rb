require 'linked_list'

class HashTable
  def initialize(size = 10)
    @buckets = Array.new(size)
  end

  def set(key, value)
    buckets[bucket_index(key)] = SinglyLinkedList.new(
      value: [key, value],
      tail: buckets[bucket_index(key)]
    )
  end

  def get(key)
    _, value = buckets[bucket_index(key)]&.find { |n| n.value[0] == key }&.value
    value
  end

  private

  attr_reader :buckets

  def bucket_index(key)
    key.hash % buckets.length
  end
end
