class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    set_prev_node_to_next_node
    set_next_node_to_prev_node
    self
  end

  private
  def set_prev_node_to_next_node
    return false if @prev.nil?

    @prev.next = @next
  end

  def set_next_node_to_prev_node
    return false if @next.nil?

    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
    make_end_nodes
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    last == @head
  end

  def get(key)
    each { |node| return node.val if node.key == key }

    nil
  end

  def include?(key)
    each { |node| return true if node.key == key}

    false
  end

  def append_new(key, val)
    new_node = Node.new(key, val)
    update_surrounding_nodes(new_node, @tail.prev, @tail)
  end

  def append_existing(node)
    update_surrounding_nodes(node, @tail.prev, @tail)
  end

  def each
    node = @head.next
    until node == @tail
      yield node
      node = node.next
    end

    nil
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private
  def make_end_nodes
    head = Node.new(:head, nil)
    tail = Node.new(:tail, nil)
    head.next = tail
    tail.prev = head
    @head = head
    @tail = tail
  end

  def update_surrounding_nodes(node, prev_node, next_node)
    node.prev = prev_node
    node.next = next_node
    prev_node.next = node
    next_node.prev = node
    node
  end

  def find(key)
    each { |node| return node if node.key == key}
    nil
  end
end
