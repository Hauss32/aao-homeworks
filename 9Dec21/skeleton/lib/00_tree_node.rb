require "byebug"

class PolyTreeNode
    attr_reader :value, :parent
    attr_accessor :children

    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def inspect
        p_val = @parent.nil? ? nil : @parent.value
        c_vals = @children.map(&:value)

        { v: @value, p: p_val, c: c_vals }
    end

    def parent=(node)
        if node
            node.children << self unless node.children.include?(self)
        end

        if @parent
            @parent.children.delete(self) unless @parent == node
        end
        
        @parent = node
    end

    def add_child(node)
        node.parent = self
    end

    def remove_child(node)
        raise "Not a child node!" if node.parent.nil?
        node.parent = nil
    end

    def dfs(target)
        return self if @value == target

        @children.each do |child|
            found_child = child.dfs(target)
            return found_child unless found_child.nil?
        end

        nil
    end

    def bfs(target)
        queue = [self]

        until queue.empty?
            node = queue.shift
            return node if node.value == target
            queue += node.children
        end

        nil
    end
end

# n1 = PolyTreeNode.new('root')
# n2 = PolyTreeNode.new('c1')
# n3 = PolyTreeNode.new('c2')

# n3.parent = n1
# n3.parent = n1
# n2.parent = n1
# n3.parent = n2