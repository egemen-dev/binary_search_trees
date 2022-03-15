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

  def find(x, node = root)
    if node.nil?
      nil
    elsif node.data == x
      node
    elsif node.data > x
      find(x, node.left)
    elsif node.data < x
      find(x, node.right)
    end
  end

  def find_parent(x, node = root)
    if node.data == x
      x_node
    elsif node.data > x
      @x_node = node
      find_parent(x, node.left)
    else
      @x_node = node
      find_parent(x, node.right)
    end
  end

  def find_last_left(x, node = root)
    if node.nil?
      x_node
    elsif node.data > x
      @x_node = node
      find_last_left(x, node.left)
    else
      find_last_left(x, node.right)
    end
  end

  def maximium(node = root)
    node = node.right until node.right.nil?
    node
  end

  def minimum(node = root)
    node = node.left until node.left.nil?
    node
  end

  def successor(x)
    node = find(x)
    if node.right.nil?
      find_last_left(x)
    else
      minimum(node.right)
    end
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
    parent = find_parent(key)
    target = find(key)

    # case 1: leaf
    if target.left.nil? && target.right.nil?
      if parent.left.data == key && !parent.left.nil?
        parent.left = nil
      elsif parent.right.data == key && !parent.right.nil?
        parent.right = nil
      end

    # case 2: one child node
    elsif target.left.nil? || target.right.nil?
      if parent.left.data == target.data
        target.right.nil? ? @x_node = target.left : @x_node = target.right
        parent.left = x_node
      elsif parent.right.data == target.data
        target.right.nil? ? @x_node = target.left : @x_node = target.right
        parent.right = x_node
      end

    # case 3: two children node
    elsif target.left && target.right
      suc = successor(key)
      delete(suc.data)
      target.data = suc.data
    end
  end
  # def delete(key, node = root)
  #   # case1: leaf node
  #   if node.nil?
  #     'done'
  #   elsif node.data > key
  #     if node.left.nil?
  #       p "it does't exist already"
  #     elsif node.left.data == key && !(node.left.left || node.left.right)
  #       node.left = nil
  #     end
  #     delete(key, node.left)
  #   elsif node.data < key
  #     if node.right.nil?
  #       p "it does't exist already"
  #     elsif node.right.data == key && !(node.right.left || node.right.right)
  #       node.right = nil
  #     end
  #     delete(key, node.right)
  #   end

  #   # case2: one child deletion
  #   if node.nil?
  #     "done"
  #   elsif node.data > key
  #     if node.left.nil?
  #       p "it does't exist already"
  #     elsif node.left.data == key
  #       node.left = node.left.left if node.left.right.nil?
  #     end
  #     delete(key, node.left)
  #   elsif node.data < key
  #     if node.right.nil?
  #       p "it does't exist already"
  #     elsif node.right.data == key
  #       node.right = node.right.right if node.right.left.nil?
  #     end
  #     delete(key, node.right)
  #   end

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
  # end

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

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

x = Tree.new(array)
# x.insert(10)
x.insert(5.5)
x.insert(4.5)
x.insert(3.6)
x.insert(9.2)
x.pretty_print
# x.delete(8)
# p x.maximium.data
# p x.minimum.data
# p x.find(7)
# p x.find_last_left(9)
# p x.successor(9).data
x.delete(8)
x.pretty_print
# p x.find_parent(8).data
# p x.preorder(x.root)
# p x.preorder(root)

# p a = [0,1,3]
# p a[(a.length/2)]
# p left = a[0...(a.length/2)]
# p right = a[(a.length/2)+1..-1]
# p left[0...(a.length/2)]
