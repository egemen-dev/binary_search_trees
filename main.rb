class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root, :x_node

  def initialize(array)
    @array = array.sort!.uniq!
    @root = build_tree(array)
    @x_node = nil
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.length / 2)
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid + 1..-1])
    root
  end

  def insert(key, node = root)
    if node.nil?
      "no data"
    elsif node.data > key
      node.left = Node.new(key) if node.left.nil?
      insert(key, node.left)
    elsif node.data < key
      node.right = Node.new(key) if node.right.nil?
      insert(key, node.right)
    end
  end

  def delete(key, node = root)
    # case1: leaf node
    if node.nil?
      'done'
    elsif node.data > key
      if node.left.nil?
        p "it does't exist already"
      elsif node.left.data == key && !(node.left.left || node.left.right)
        node.left = nil
      end
      delete(key, node.left)
    elsif node.data < key
      if node.right.nil?
        p "it does't exist already"
      elsif node.right.data == key && !(node.right.left || node.right.right)
        node.right = nil
      end
      delete(key, node.right)
    end

    # case2: one child deletion
    if node.nil?
      "done"
    elsif node.data > key
      if node.left.nil?
        p "it does't exist already"
      elsif node.left.data == key
        node.left = node.left.left if node.left.right.nil?
      end
      delete(key, node.left)
    elsif node.data < key
      if node.right.nil?
        p "it does't exist already"
      elsif node.right.data == key
        node.right = node.right.right if node.right.left.nil?
      end
      delete(key, node.right)
    end

    # case3: two child node deletion
    # if node.nil?
    #   "done"
    # elsif node.data == key
    #   @x_node = node
    #   delete(key, node.right)
    # elsif node.data > key
    #   x_node.data = node.data if node.left.nil?
    #   delete(key, node.left)
    # elsif node.data < key
    #   x_node.data = node.data if node.right.nil?
    #   delete(key, node.right)
    # end
  end

  def inorder(node, output = [])
    return if node.nil?

    inorder(node.left, output)
    output << node.data
    inorder(node.right, output)
    output
  end

  def preorder(node, output = [])
    return if node.nil?

    p output << node.data
    preorder(node.left, output)
    preorder(node.right, output)
    output
  end

  def postorder(node, output = [])
    return if node.nil?

    postorder(node.left, output)
    postorder(node.right, output)
    output << node.data
    output
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

array = [1, 2, 3, 4, 5, 6, 7]

x = Tree.new(array)
x.insert(10)
x.insert(0)
x.insert(6.95)
x.insert(1.1)
# x.delete(8)
x.pretty_print
# p x.preorder(x.root)
# p x.preorder(root)

# p a = [0,1,3]
# p a[(a.length/2)]
# p left = a[0...(a.length/2)]
# p right = a[(a.length/2)+1..-1]
# p left[0...(a.length/2)]
