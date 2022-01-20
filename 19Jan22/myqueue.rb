class MyQueue
  def initialize
    @store = []
  end

  def peek
      @store[0]
  end

  def size
      @store.size
  end

  def empty?
      @store.empty?
  end

  def enqueue(num)
      @store << num
  end

  def dequeue
      @store.unshift
  end
end