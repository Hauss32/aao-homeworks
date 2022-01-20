# Given an array of unique integers and a target sum, determine whether any two 
# integers in the array sum to that amount.

# Let's start by implementing the brute force solution. Write a method called 
# bad_two_sum?, which checks every possible pair.

def bad_two_sum?(nums_arr, target)

    (0...nums_arr.length - 1).each do |idx|
        (idx + 1...nums_arr.length).each do |other_idx|
            return true if nums_arr[idx] + nums_arr[other_idx] == target
        end
    end

    false
end

# write a comment with your solution's time complexity.
# => This method uses two loops, each on n-complexity = O(n^2)

# ————————————————————

# Write a second solution, called okay_two_sum?, which uses sorting.

def okay_two_sum?(nums_arr, target)
    sorted = nums_arr.sort

    sorted.each_with_index do |num, idx|
        needed_num = target - num
        found_num_idx = nums_arr.bsearch_index { |n| needed_num <=> n }
        puts found_num_idx
        return true if found_num_idx && found_num_idx != idx
    end

    false
end

# What does sorting do to the lower bound of your time complexity?
# => Array#sort is O(n logn) complexity, and bsearch_index is O(logn), so...
# => ...the entire method is of complecity O(n logn)

def good_two_sum?(nums_arr, target)
    nums_hash = Hash.new { |h, k| h[k] = Array.new }
    nums_arr.each_with_index { |num, idx| nums_hash[num] << idx }

    nums_arr.each do |num|
        needed_num = target - num

        if num == needed_num
            return true if nums_hash[needed_num].length > 1 #don't count own idx
        else
            return true unless nums_hash[needed_num].empty?
        end     
    end 

    false
end

# Defend why each of your solutions has the time complexity you claim it does.
# => first loop to set hash keys/vals is O(n)
# => second loop to search hash is also O(n)
# => so overall, the method is 2n = O(n)