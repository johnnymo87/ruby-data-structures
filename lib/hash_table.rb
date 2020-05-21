require 'linked_list'

class HashTable
  def initialize(size = 10)
    @buckets = Array.new(size, LinkedList.new)
  end

  def set(key, value)
    get_bucket(key).push([key, value])
  end

  def get(key)
    _, value = get_bucket(key).find { |n| n.value[0] == key }&.value
    value
  end

  private

  attr_reader :buckets

  def get_bucket(key)
    buckets[key.hash % buckets.length]
  end
end
