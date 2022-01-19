#First, write a function that compares each element to every other element of the list. 
#Return the element if all other elements in the array are larger.

def slow_min(nums)
    nums.each do |num|
        smallest = true
        nums.each do |other_num|
            if other_num < num
                smallest = false
                break
            end
        end

        return num if smallest
    end

    nil
end

# What is the time complexity for this function?
# => O(n^2)

#Now rewrite the function to iterate through the list just once while keeping 
#track of the minimum. 

def faster_min(nums)
    min = nums[0]

    nums.each { |num| min = num if num < min}

    min
end

# What is the time complexity?
# => O(n)

# ————————————————

# You have an array of integers and you want to find the largest contiguous 
# (together in sequence) sub-sum. Find the sums of all contiguous sub-arrays 
# and return the max. 

# Write a function that iterates through the array and finds all
# sub-arrays using nested loops.

def largest_contiguous_subsum_slow(list)
    sub_arrs = []

    (0...list.length).each do |idx|
        (idx...list.length).each do |other_idx|
            sub_arrs << list[idx..other_idx]
        end
    end

    max_sum = sub_arrs[0].sum

    sub_arrs.each do |sub_arr| 
        sum = sub_arr.sum
        max_sum = sum if sum > max_sum
    end

    max_sum
end

#Discuss the time complexity of this solution.
# => Nested loops for sub_arrs is n^2
# => Assuming Array.sum is O(n) for each sub_arr...
# => n^2 * n = O(n^3)

# Let's make a better version. Write a new function using O(n) time with O(1) memory.

def largest_contiguous_subsum_fast(list)
    max_sum = list[0]
    current_sum = list[0]

    (1...list.length).each do |idx|
        if current_sum < 0
            current_sum = 0 #a negative sum will always lower max, so start with 0 instead
        end

        current_sum += list[idx]

        max_sum = current_sum if current_sum > max_sum
    end

    max_sum
end

#Space is constant since vars are reassigned O(1)
#Time is linear since we only loop once O(n)