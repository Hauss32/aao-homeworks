require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = Hash.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map[key])
    else  
      calc!(key)
    end

    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    node = @store.append_new(key, val)
    @map[key] = node
    eject! if count > @max
  end

  def update_node!(node)
    node.remove
    @store.append_existing(node)
  end

  def eject!
    least_recently_used = @store.first
    least_recently_used.remove
    @map.delete(least_recently_used.key)
  end
end
