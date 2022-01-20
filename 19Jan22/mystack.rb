class MyStack
  def initialize(store=[])
    @store = store
  end

  def peek
    @store[-1]
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def push(item)
    @store << item
  end

  def pop
    @store.pop
  end
end