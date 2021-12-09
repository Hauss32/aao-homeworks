class Queue
    def initialize
        @arr = []
    end

    def enqueue(el)
        @arr.push(el)
    end

    def dequeue
        @arr.shift
    end

    def peek
        @arr[0]
    end
end


q = Queue.new
q.enqueue('first')
q.enqueue('second')
q.enqueue('third')
p q.peek == 'first'
p q.dequeue == 'first'
p q.dequeue == 'second'
p q.dequeue == 'third'