require_relative 'node'

class Tree
  attr_accessor :root, :array, :x_node

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
      'no data'
    elsif node.data > key
      node.left = Node.new(key) if node.left.nil?
      insert(key, node.left)
    elsif node.data < key
      node.right = Node.new(key) if node.right.nil?
      insert(key, node.right)
    end
  end

  def delete(key, _node = root)
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
        @x_node = target.right.nil? ? target.left : target.right
        parent.left = x_node
      elsif parent.right.data == target.data
        @x_node = target.right.nil? ? target.left : target.right
        parent.right = x_node
      end

    # case 3: two children node
    elsif target.left && target.right
      suc = successor(key)
      delete(suc.data)
      target.data = suc.data
    end
  end

  # Breadth First Search
  def level_order(result = [], queue = [], node = root)
    queue << node
    until queue.empty?
      kicked = queue.shift # dequeue
      result << kicked.data
      queue << kicked.left unless kicked.left.nil?
      queue << kicked.right unless kicked.right.nil?
      yield(kicked) if block_given?
    end
    result
  end

  def level_order_recursive(result = [], queue = [], node = root, &block)
    queue << node if result.empty?

    unless queue.empty?
      kicked = queue.shift # dequeue
      result << kicked.data
      queue << kicked.left unless kicked.left.nil?
      queue << kicked.right unless kicked.right.nil?
      yield(kicked) if block_given?
      level_order_recursive(result, queue, &block)
    end
    result
  end

  def inorder(node = root, output = [])
    return if node.nil?

    inorder(node.left, output)
    output << node.data
    inorder(node.right, output)
    output
  end

  def preorder(node = root, output = [])
    return if node.nil?

    output << node.data
    preorder(node.left, output)
    preorder(node.right, output)
    output
  end

  def postorder(node = root, output = [])
    return if node.nil?

    postorder(node.left, output)
    postorder(node.right, output)
    output << node.data
    output
  end

  def height(node = root)
    if node.nil?
      -1
    else
      node = find(node) if node.is_a?(Integer)
      left = height(node.left)
      right = height(node.right)
      if left > right
        1 + left
      else
        1 + right
      end

    end
  end

  def depth(x, node = root, edges = 0)
    if node.nil?
      nil
    elsif node.data == x
      edges
    elsif node.data > x
      edges += 1
      depth(x, node.left, edges)
    elsif node.data < x
      edges += 1
      depth(x, node.right, edges)
    end
  end

  def balanced?(node = root, l = 0, r = 0)
    l = height(node.left) if node.left
    r = height(node.right) if node.right
    (l - r).abs < 2
  end

  # Creates a new balanced tree.
  def rebalance(node = root)
    inorder = inorder(node)
    Tree.new(inorder)
  end

  # Balances the current tree. (bang method !)
  def rebalance!(node = root)
    @array = inorder(node)
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
