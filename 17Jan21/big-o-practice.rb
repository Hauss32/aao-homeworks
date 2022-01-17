def sluggish_octopus(fish_arr)
    biggest_fish = fish_arr[0]

    fish_arr.each do |fish|
        fish_size = fish.length
        next unless fish_size > biggest_fish.length

        fish_arr.each do |other_fish|
            other_fish_size = other_fish.length
            
            if other_fish_size > fish_size && other_fish_size > biggest_fish.length
                biggest_fish = other_fish
            end
        end
    end

    biggest_fish
end

def dominant_octopus(fish_arr)
    merge_sort!(fish_arr)
    biggest = fish_arr[-1]

    biggest
end

def merge_sort!(fish_arr)
    return fish_arr if fish_arr.length <= 1

    mid_idx = fish_arr.length / 2
    left = fish_arr.take(mid_idx)
    right = fish_arr.drop(mid_idx)

    merge(merge_sort!(left), merge_sort!(right))
end

def merge(arr_1, arr_2)
    merged_arr = []

    until arr_1.empty? || arr_2.empty?
        if arr_1.first.length < arr_2.first.length
            merged_arr << arr_1.shift
        else
            merged_arr << arr_2.shift
        end
    end

    merged_arr + arr_1 + arr_2
end

def clever_octopus(fish_arr)
    biggest = fish_arr[0]

    fish_arr.each do |fish|
        biggest = fish if fish.length > biggest.length
    end

    biggest
end

def slow_dance(move, moves_arr)
    moves_arr.each_with_index do |move_dir, idx|
        return idx if move_dir == move
    end

    -1
end

def fast_dance(move, moves_hash)
    moves_hash[move]
end

fish_arr = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

p sluggish_octopus(fish_arr)
p merge_sort!(fish_arr)
p dominant_octopus(fish_arr)
p clever_octopus(fish_arr)

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
tiles_hash = {
    "up" => 0,
    "right-up" => 1,
    "right" => 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

p slow_dance("right-down", tiles_array)
p fast_dance("right-down", tiles_hash)
