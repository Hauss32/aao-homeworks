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

  def append(key, val)
    higher_node = each { |node| node.val > val }
    higher_node ||= @tail

    new_node = Node.new(key, val)
    update_surrounding_nodes(new_node, higher_node.prev, higher_node)
  end

  def update(key, val)
    if key == :head || key == :tail
      raise "Head and Tail nodes cannot be updated."
    end
    node = find(key)
    return false unless node
    node.remove
    append(key, val)
  end

  def remove(key)
    if key == :head || key == :tail
      raise "Head and Tail nodes cannot be removed."
    end
    node = find(key)
    return false unless node
    node.remove
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

  def update_surrounding_nodes(new_node, prev_node, next_node)
    new_node.prev = prev_node
    new_node.next = next_node
    prev_node.next = new_node
    next_node.prev = new_node
  end

  def find(key)
    each { |node| return node if node.key == key}
    nil
  end
end
