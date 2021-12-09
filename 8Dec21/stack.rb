  class Stack
    def initialize
      @arr = []
    end

    def push(el)
      @arr.push(el)
    end

    def pop
      @arr.pop
    end

    def peek
      @arr[-1]
    end
  end

  s = Stack.new
  s.push('first')
  s.push('second')
  s.push('third')
  p s.peek == 'third'
  p s.pop == 'third'
  p s.pop == 'second'
  p s.pop == 'first'