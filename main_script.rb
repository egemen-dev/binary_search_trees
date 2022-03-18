require_relative './lib/tree'

array = (Array.new(15) { rand(1..100) })
tree_1 = Tree.new(array)

puts "first tree ^^^^^^^^^^^^ #{tree_1.pretty_print}"
puts "first tree balanced?   ->  #{tree_1.balanced?}"
puts "first tree level order ->  #{tree_1.level_order}"
puts "first tree preorder    ->  #{tree_1.preorder}"
puts "first tree postorder   ->  #{tree_1.postorder}"
puts "first tree inorder     ->  #{tree_1.inorder}"

puts "\nInsertions to unbalance the tree\n "
tree_1.insert(7600)
tree_1.insert(7650)
tree_1.insert(7670)
tree_1.pretty_print

puts "first tree balanced after insertions? ->  #{tree_1.balanced?}"
puts "first tree balanced after insertions? ->  #{tree_1.balanced?}"
puts "balances the current tree ->  #{tree_1.rebalance!}"
puts "balanced tree ^^^^^^^^^^^^ #{tree_1.pretty_print}"
puts "tree balanced?   ->  #{tree_1.balanced?}"
puts "tree level order ->  #{tree_1.level_order}"
puts "tree preorder    ->  #{tree_1.preorder}"
puts "tree postorder   ->  #{tree_1.postorder}"
puts "tree inorder     ->  #{tree_1.inorder}"

#level, pre, postorder usage with a block:

# tree_1.level_order do |node|
#   puts "node data: #{node.data}"
# end

# tree_1.level_order { |node| puts "node data: #{node.data}" }
# tree_1.level_order_recursive { |node| puts "node data: #{node.data}" }
# tree_1.preorder { |node| puts "node data preorder: #{node.data}" }
# tree_1.postorder { |node| puts "node data postorder: #{node.data}" }
# tree_1.inorder { |node| puts "node data inorder: #{node.data}" }
