require 'minitest/autorun'
require 'hash_table'

describe HashTable do
  describe '#get' do
    before { @ht = HashTable.new }

    it 'returns values that have been set' do
      @ht.set('hello', 'world')
      @ht.get('hello').must_equal('world')
    end

    it 'otherwise returns nil' do
      assert_nil(@ht.get('hello'))
    end
  end
end
