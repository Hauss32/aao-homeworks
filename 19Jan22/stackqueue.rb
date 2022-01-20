require_relative 'mystack'

class StackQueue
    def initialize
        @stack_1 = MyStack.new
        @stack_2 = MyStack.new
    end

    def size
        @stack_1.size + @stack_2.size
    end

    def empty?
        @stack_1.empty? && @stack_2.empty?
    end

    def enqueue(val)
        @stack_1.push(val)
    end

    def dequeue
        reverse_stack if @stack_2.empty?

        @stack_2.pop
    end

    private
    def reverse_stack
        until @stack_1.empty?
            @stack_2.push(@stack_1.pop)
        end
    end
end