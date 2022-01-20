require_relative 'minmaxstack'

class MinMaxStackQueue
    def initialize
        @stack_1 = MinMaxStack.new
        @stack_2 = MinMaxStack.new
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

    def max
        nums = []
        nums << @stack_1.max unless @stack_1.empty?
        nums << @stack_2.max unless @stack_2.empty?
        nums.max
    end

    def min
        nums = []
        nums << @stack_1.min unless @stack_1.empty?
        nums << @stack_2.min unless @stack_2.empty?
        nums.min
    end

    private
    def reverse_stack
        until @stack_1.empty?
            @stack_2.push(@stack_1.pop)
        end
    end
end