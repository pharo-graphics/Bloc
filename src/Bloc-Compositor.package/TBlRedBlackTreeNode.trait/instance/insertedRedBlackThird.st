private - inserting
insertedRedBlackThird
	"Case 3: If both the parent P and the uncle U are red, then both of them can be repainted black and the grandparent G becomes red (to maintain property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes)). Now, the current red node N has a black parent.
	Since any path through the parent or uncle must pass through the grandparent, the number of black nodes on these paths has not changed.
	However, the grandparent G may now violate properties 2 (The root is black) or 4 (Both children of every red node are black) (property 4 possibly being violated since G may have a red parent).
	To fix this, the entire procedure is recursively performed on G from case 1.
	Note that this is a tail-recursive call, so it could be rewritten as a loop; since this is the only loop, and any rotations occur after this loop, this proves that a constant number of rotations occur."
	
	"
	struct node *u = uncle(n), *g;

 if ((u != NULL) && (u->color == RED)) {
  n->parent->color = BLACK;
  u->color = BLACK;
  g = grandparent(n);
  g->color = RED;
  insert_case1(g);
 } else {
  insert_case4(n);
 }
	
	
	"