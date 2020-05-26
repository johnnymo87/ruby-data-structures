require 'minitest/autorun'

describe <<-Q do
Given a directed graph, design an algorithm to find out whether there is a
route between two nodes.
Q

  class DirectedGraph
    def self.from_hash_table(hash_table)
      name_map = hash_table.keys.each_with_object({}) do |name, cache|
        node = cache[name] ||= Node.new(name: name)
        hash_table[name].each do |child_name|
          node.children << cache[child_name] ||= Node.new(name: child_name)
        end
      end
      new(name_map.values)
    end

    attr_reader :nodes

    def initialize(nodes)
      @nodes = nodes
    end

    def route_between?(a, b)
      raise NotFound unless a = nodes.find { |node| node.name == a }
      raise NotFound unless b = nodes.find { |node| node.name == b }

      route_is_found = a.has_route_to?(b)
      nodes.each(&:reset)
      route_is_found
    end

    private

    class NotFound < StandardError; end

    class Node
      def initialize(name:)
        @name = name
        @children = []
        @visited = false
      end

      def has_route_to?(other, queue = [])
        self.visited = true

        return true if name == other.name

        children.reject(&:visited).each { |child| queue << child }

        return false if queue.empty?

        node = queue.shift

        node.has_route_to?(other, queue)
      end

      def reset
        self.visited = false
      end

      attr_reader :name
      attr_accessor :children
      attr_reader :visited

      private

      attr_writer :visited
    end
  end

  describe 'building a graph' do
    describe '.from_hash_table' do
      it 'works' do
        schema = {
          0 => [1],
          1 => [2],
          2 => [0],
          3 => [2],
        }
        graph = DirectedGraph.from_hash_table(schema)
        graph.nodes.each_with_object({}) do |node, cache|
          cache[node.name] = node.children.map(&:name)
        end.must_equal(schema)
      end
    end
  end

  describe 'working with an existing graph' do
    before do
      @graph = DirectedGraph.from_hash_table({
        0 => [1, 5],
        1 => [3, 4],
        2 => [1],
        3 => [2, 4],
        4 => [],
        5 => [],
      })
    end

    describe '#route_between?' do
      it 'returns true if a route exists' do
        @graph.route_between?(0, 2)
      end

      it 'otherwise returns false' do
        @graph.route_between?(1, 5)
      end
    end
  end
end
