require_relative 'minmaxstackqueue'

def windowed_max_range(array, window_size)
    current_max_range = nil

    (0..array.length - window_size).each do |offset|
        arr_window = array[offset...window_size + offset]
        max = arr_window.max
        min = arr_window.min
        range = max - min
        current_max_range = range if current_max_range.nil? || range > current_max_range
    end

    current_max_range
end

# Think about the time complexity of your method. How many iterations are 
# required at each step? What is its overall time complexity in Big-O notation?
# => Loop through each window is O(n)...
# => ...Array#slice/max/min all seem to be O(n) = 3n = O(n) overall...
# => ...I think this is O(n^2) time complexity


# ———————————————————
# Armed with a working MinMaxStackQueue, this problem should be much easier. 
# You'll want to follow the same basic approach as above, but use our new data 
# structure instead of array slices.

def better_windowed_max_range(array, window_size)
    min_max_queue = MinMaxStackQueue.new
    current_max_range = nil
    i = 0
    until min_max_queue.size == window_size
        min_max_queue.enqueue(array[i])
        i += 1
    end

    window_range = min_max_queue.max - min_max_queue.min
    current_max_range = window_range if current_max_range.nil? || window_range > current_max_range

    until i == array.length
        min_max_queue.dequeue
        min_max_queue.enqueue(array[i])
        window_range = min_max_queue.max - min_max_queue.min
        current_max_range = window_range if window_range > current_max_range
        i += 1
    end
    current_max_range
end
