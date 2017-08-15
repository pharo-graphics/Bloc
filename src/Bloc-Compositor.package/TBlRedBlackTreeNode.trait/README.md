I define an API of a Node in Red-Black Tree as described here https://en.wikipedia.org/wiki/Red–black_tree

In addition to the requirements imposed on a binary search tree the following must be satisfied by a red–black tree:

1) Each node is either red or black.
2) The root is black. This rule is sometimes omitted. Since the root can always be changed from red to black, but not necessarily vice versa, this rule has little effect on analysis.
3) All leaves (NIL) are black.
4) If a node is red, then both its children are black.
5) Every path from a given node to any of its descendant NIL nodes contains the same number of black nodes. Some definitions: the number of black nodes from the root to a node is the node's black depth; the uniform number of black nodes in all paths from root to the leaves is called the black-height of the red–black tree.