# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

require 'bst_node'
require 'byebug'

class BinarySearchTree
  attr_accessor :root
  def initialize(root = nil)
    @root = root
  end

  def insert(value)
    new_node = BSTNode.new(value)
    if !@root
      @root = new_node
    else
      insert_helper(new_node, @root)
    end
  end

  def find(value, tree_node = @root)
    check_val = tree_node.value
    if check_val == value
      return tree_node
    elsif value < check_val && tree_node.left
      find(value, tree_node.left)
    elsif value > check_val && tree_node.right
      find(value, tree_node.right)
    else
      return nil
    end
  end

  def delete(value)
    node_to_delete = find(value)
    if node_to_delete == @root
      @root = nil
    elsif !node_to_delete.left && !node_to_delete.right
      delete_helper(node_to_delete, nil)
    elsif node_to_delete.left && !node_to_delete.right
      delete_helper(node_to_delete, node_to_delete.left)
    elsif !node_to_delete.left && node_to_delete.right
      delete_helper(node_to_delete, node_to_delete.right)
    else
      max_node = maximum(node_to_delete.left)
      max_node.parent.right = max_node.left
      delete_helper(node_to_delete, max_node)
      max_node.left = node_to_delete.left
      max_node.left.parent = max_node
      max_node.right = node_to_delete.right
      max_node.right.parent = max_node
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right
      maximum(tree_node.right)
    else
      return tree_node
    end
  end

  def depth(tree_node = @root)
    return 0 if tree_node == nil || (!tree_node.left && !tree_node.right)
    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)
    return 1 + (left_depth > right_depth ? left_depth : right_depth)
  end

  def is_balanced?(tree_node = @root)
    if (!tree_node.left && !tree_node.right) ||
      (!tree_node.left && depth(tree_node.right) == 0) ||
      (!tree_node.right && depth(tree_node.left) == 0) ||
      ([0, 1].include?(depth(tree_node.left) && [0, 1].include?(depth(tree_node.right))))
      return true
    elsif depth(tree_node.left) - depth(tree_node.right) > 1
      return false
    elsif is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
      return true
    else
      return false
    end
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  # optional helper methods go here:

  def insert_helper(node_to_insert, node_to_check)
    left_child_exists = !!node_to_check.left
    right_child_exists = !!node_to_check.right
    insert_val = node_to_insert.value
    check_val = node_to_check.value
    if insert_val <= check_val && left_child_exists
      insert_helper(node_to_insert, node_to_check.left)
    elsif insert_val <= check_val
      node_to_check.left = node_to_insert
      node_to_insert.parent = node_to_check
    elsif insert_val > check_val && right_child_exists
      insert_helper(node_to_insert, node_to_check.right)
    elsif insert_val > check_val
      node_to_check.right = node_to_insert
      node_to_insert.parent = node_to_check
    end
  end

  def delete_helper(node_to_delete, node_to_replace_with)
    if node_to_delete.parent.left == node_to_delete
      node_to_delete.parent.left = node_to_replace_with
    elsif node_to_delete.parent.right == node_to_delete
      node_to_delete.parent.right = node_to_replace_with
    end
  end

end
