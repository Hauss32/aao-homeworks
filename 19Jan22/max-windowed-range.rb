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
