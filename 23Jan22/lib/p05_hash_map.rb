require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)
    bucket.include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    bucket = bucket(key)

    if bucket.include?(key)
      return bucket.update(key, val)
    else
      result = bucket.append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket = bucket(key)
    bucket.get(key)
  end

  def delete(key)
    bucket = bucket(key)
    result = bucket.remove(key)
    @count -= 1 if result
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times { @store << LinkedList.new }
    reallocate!
  end

  def reallocate!
    all_key_val = get_all_key_val
    reset_buckets
    all_key_val.each { |key_val| set(*key_val) }
  end

  def get_all_key_val
    key_vals = []
    each { |key, val| key_vals << [key, val] }
    key_vals
  end

  def reset_buckets
    @store.each { |bucket| bucket = LinkedList.new }
  end

  def bucket(key)
    bucket_idx = key.hash % num_buckets
    @store[bucket_idx]
  end
end
