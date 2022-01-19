# Write a method #first_anagram? that will generate and store all the possible 
# anagrams of the first string. Check if the second string is one of these.

def first_anagram?(str_1, str_2)
    word_permutations = anagram_permutations(str_1)

    word_permutations.include?(str_2)
end

def anagram_permutations(str)
    return [str, str.reverse] if str.length <= 2

    permutations = []

    (0...str.length).each do |idx|
        str_dup = str.dup
        char = str_dup.slice!(idx)
        anagram_permutations(str_dup).each { |perm| permutations << char + perm }
    end

    permutations
end

# What is the time complexity of this solution? 
# What happens if you increase the size of the strings?

# => There's a loop for every char in the str, which creates a new branch with...
# => ...a loop of n-1 size, so this seems like O(n!) complexity


# ————————————————————

# Write a method #second_anagram? that iterates over the first string. 
# For each letter in the first string, find the index of that letter in 
# the second string (hint: use Array#find_index) and delete at that index.

def second_index?(str_1, str_2)
    str_2_dup = str_2.dup
    str_1.chars.each do |char|
        str_2_char_idx = str_2_dup.index(char)
        return false unless str_2_char_idx
        str_2_dup.slice!(str_2_char_idx)
    end

    true
end

# What are the differences between #first_anagram? and #second_anagram? ?
# => first_anagram makes recursive branches until the str length is down to 2...
# => ...leading to O(n!) complexity. second_anagram? only loops through the...
# => ...strings's chars once. So assuming String#index is O(n), which is nested...
# => ...in the loop, this would be O(n^2) complexity.


# ————————————————————

# Write a method #third_anagram? that solves the problem by sorting both strings 
# alphabetically. The strings are then anagrams if and only if the sorted 
# versions are the identical.

def third_anagram?(str_1, str_2)
    str_1_sorted = str_1.chars.sort.join
    str_2_sorted = str_2.chars.sort.join

    str_1_sorted == str_2_sorted
end

# What is the time complexity of this solution? 
# Is it better or worse than #second_anagram? ?
# => Ruby's sort method (Quicksort) is O(n^2) as a worst case, so this seems similar to...
# => ... second_anagram? However, avg complexity for Quicksort is O(n logn)...
# => ... so this one is probably faster


# ————————————————————

# Write one more method #fourth_anagram?. This time, use two Hashes 
# to store the number of times each letter appears in both words.

def fourth_anagram?(str_1, str_2)
    str_1_hash = Hash.new { |h, k| h[k] = 0 }
    str_2_hash = Hash.new { |h, k| h[k] = 0 }

    str_1.chars.each { |char| str_1_hash[char] += 1 }
    str_2.chars.each { |char| str_2_hash[char] += 1 }

    str_1_hash.keys.each do |char|
        return false unless str_1_hash[char] == str_2_hash[char]
    end

    true
end

# What is the time complexity?
# => This method has 3 individual loops, resulting in 3n complexity = O(n)