class Map
    def initialize
        @arr = []
    end

    def set(key, val)
        existing_idx = self.send(:index, key)

        if existing_idx
            @arr[existing_idx][1] = val
        else
            @arr.push([key, val])
        end
    end

    def get(key)
        existing_idx = self.send(:index, key)

        return @arr[existing_idx][1] if existing_idx

        nil
    end

    def delete(key)
        existing_idx = self.send(:index, key)
        return false unless existing_idx

        @arr.slice!(existing_idx, 1)

        true
    end

    def show
        @arr
    end

    private
    def index(key)
        return nil if @arr.empty?
        @arr.each_with_index { |el, idx| return idx if el[0] == key }

        nil
    end
end

ele_1 = [1,"one"]
ele_2 = [2,"two"]

ele_1_mod = [1,"one_mod"]

map = Map.new

map.set(*ele_1)
p map.show.length == 1
p map.get(1) == ele_1[1]
map.set(*ele_2)
p map.show.length == 2
map.set(*ele_1_mod)
p map.show.length == 2
p map.get(1) == 'one_mod'
map.delete(1)
p map.show.length == 1
map.delete(3)
p map.show.length == 1
