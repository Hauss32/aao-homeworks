require_relative "poly-tree-node"

class KnightClassFinder
    def self.valid_moves(pos)
        board_size = 8
        vert_moves = [-2,2].product([-1,1])
        horiz_moves = [-1,1].product([-2,2])
        all_moves = vert_moves + horiz_moves
        valid_moves = []

        all_moves.each do |move|
            new_y = pos[0] + move[0]
            new_x = pos[1] + move[1]
            valid_idxs = (0...board_size).to_a
            valid_move = valid_idxs.include?(new_y) && valid_idxs.include?(new_x)
            
            valid_moves << [new_y, new_x] if valid_move
        end

        valid_moves
    end

    attr_reader :root_node

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = []

    end

    def new_move_positions(pos)
        valid_positions = KnightClassFinder.valid_moves(pos)
        valid_and_new = valid_positions.select { |pos| !@considered_positions.include?(pos) }
        @considered_positions += valid_and_new

        valid_and_new
    end

    def build_move_tree(target)
        queue = [self.root_node]

        until queue.empty?
            node = queue.shift
            return node if node.value == target

            new_moves = self.new_move_positions(node.value)

            child_nodes = new_moves.map do |pos| 
                child = PolyTreeNode.new(pos)
                child.parent = node
            end

            queue += node.children
        end

        nil
    end

end

p kcf = KnightClassFinder.new([1,1])
# # p KnightClassFinder.valid_moves([1,1])
# p kcf
# p kcf.new_move_positions([1,1])
# p kcf
# p kcf.new_move_positions([3,2])
# p kcf
target_node =  kcf.build_move_tree([7,4])
p target_node
puts '------'
p target_node.parent
puts '------'
p kcf.root_node