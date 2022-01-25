class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
include Enumerable

  attr_reader :store

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= @count || i < -@count
    idx = (@count + i) % @count
    @store[idx]
  end

  def []=(i, val)
    if i >= capacity
      resize! until i < capacity
    end
    @count = i + 1 if i + 1 > @count
    idx = (@count + i) % @count
    @store[idx] = val
    val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each { |ele| return true if ele == val }
    false
  end

  def push(val)
    resize! if @count >= capacity
    self[@count] = val
    val
  end

  def unshift(val)
    resize! if @count >= capacity
    curr_ele = first
    (0...@count).each do |idx|
      next_ele = self[idx + 1] unless idx == @count - 1
      self[idx + 1] = curr_ele
      curr_ele = next_ele
    end
    self[0] = val

    val
  end

  def pop
    return nil if @count == 0
    last_idx = @count - 1
    last_ele = self[last_idx]
    self[last_idx] = nil
    @count -= 1
    last_ele
  end

  def shift
    return nil if @count == 0
    first_ele = first

    (0...@count).each do |idx|
      break if idx == @count - 1
      next_ele = self[idx + 1]
      self[idx] = next_ele
    end
    self[@count - 1] = nil
    @count -= 1
    first_ele
  end

  def first
    self[0]
  end

  def last
    return nil if @count == 0
    self[@count - 1]
  end

  def each
    (0...@count).each do |idx|
      yield self[idx]
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class) && count == other.count
    (0...@count).each { |idx| return false unless self[idx].hash == other[idx].hash }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_capacity = capacity * 2
    new_arr = StaticArray.new(new_capacity)
    (0...@count).each { |idx| new_arr[idx] = self[idx] }
    @store = new_arr
  end
end
