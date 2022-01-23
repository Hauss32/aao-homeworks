class MaxIntSet
  attr_reader :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num) 
    validate!(num)

    @store[num] = true
  end

  def remove(num)
    validate!(num)

    @store[num] = false
  end

  def include?(num)
    validate!(num)

    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = @store[num % 20]

    bucket << num
  end

  def remove(num)
    bucket = @store[num % 20]

    bucket.delete(num)
  end

  def include?(num)
    bucket = @store[num % 20]

    bucket.include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    resize! if @count >= num_buckets
    bucket = num % num_buckets
    @count += 1
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % num_buckets
    deleted = @store[bucket].delete(num)
    @count -= 1 if deleted
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times { @store << Array.new }
    reallocate!
  end

  def reallocate!
    nums = @store.flatten
    empty_buckets
    nums.each { |num| @store[num % num_buckets] << num }
  end

  def empty_buckets
    @store.each { |bucket| bucket.clear}
  end
end
