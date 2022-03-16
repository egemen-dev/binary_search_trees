require_relative './lib/tree'

array = (Array.new(15) { rand(1..100) })
tree_1 = Tree.new(array)

puts "first tree ^^^^^^^^^^^^ #{tree_1.pretty_print}"
puts "first tree balanced?   ->  #{tree_1.balanced?}"
puts "first tree level order ->  #{tree_1.level_order}"
puts "first tree preorder    ->  #{tree_1.preorder}"
puts "first tree postorder   ->  #{tree_1.postorder}"
puts "first tree inorder     ->  #{tree_1.inorder}"

puts "\nInsertions to unbalance the tree\n"
tree_1.insert(7600)
tree_1.insert(7650)
tree_1.insert(7670)
tree_1.pretty_print

puts "first tree balanced after insertions? ->  #{tree_1.balanced?}"
puts "new balanced tree created ->  #{tree_2 = tree_1.rebalance}"
puts "new balanced tree ^^^^^^^^^^^^ #{tree_2.pretty_print}"
puts "new tree balanced?   ->  #{tree_2.balanced?}"
puts "new tree level order ->  #{tree_2.level_order}"
puts "new tree preorder    ->  #{tree_2.preorder}"
puts "new tree postorder   ->  #{tree_2.postorder}"
puts "new tree inorder     ->  #{tree_2.inorder}"

# All the other Tree methods works perfectly too, such as #delete, #succesosr, #find, #height...
