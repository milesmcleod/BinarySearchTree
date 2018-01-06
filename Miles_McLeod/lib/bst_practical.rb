require 'binary_search_tree'

def kth_largest(tree_node, k)
  tree = BinarySearchTree.new(tree_node)
  val = tree.in_order_traversal(tree_node)[(-1 * k)]
  return tree.find(val)
end
