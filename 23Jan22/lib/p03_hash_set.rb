class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

def insert(key)
    return false if include?(key)
    resize! if @count >= num_buckets
    bucket = key.hash % num_buckets
    @count += 1
    @store[bucket] << key
  end

  def remove(key)
    bucket = key.hash % num_buckets
    deleted = @store[bucket].delete(key)
    @count -= 1 if deleted
  end

  def include?(key)
    bucket = key.hash % num_buckets
    @store[bucket].include?(key)
  end

  private

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
