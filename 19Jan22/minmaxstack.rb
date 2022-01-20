require_relative 'mystack'

class MinMaxStack
    def initialize
        @store = MyStack.new
    end

    def peek
        @store.peek unless empty?

        nil
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def max
        return nil if empty?
        @store.peek[:max]
    end

    def min
        return nil if empty?
        @store.peek[:min]
    end

    def pop
        @store.pop[:num]
    end

    def push(num)
        min_max_hash = {
            :max => empty? ? num : [max, num].max,
            :min => empty? ? num : [min, num].min,
            :num => num
        }

        @store.push(min_max_hash)
    end
end