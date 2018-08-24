"
I define an API of a Node in Red-Black Tree as described here https://en.wikipedia.org/wiki/Red–black_tree
"
Trait {
	#name : #TBlRedBlackTreeNode,
	#category : 'Bloc-Compositor-Red-Black Tree'
}

{ #category : #inserting }
TBlRedBlackTreeNode classSide >> insertedRedBlackFifth: aRedBlackNode tree: aRedBlackTree [
	"Case 5: The parent P is red but the uncle U is black, the current node N is the left child of P, and P is the left child of its parent G. In this case, a right rotation on G is performed; the result is a tree where the former parent P is now the parent of both the current node N and the former grandparent G. G is known to be black, since its former child P could not have been red otherwise (without violating property 4). Then, the colors of P and G are switched, and the resulting tree satisfies property 4 (both children of every red node are black). Property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) also remains satisfied, since all paths that went through any of these three nodes went through G before, and now they all go through P. In each case, this is the only black node of the three."
	
	| aGrandparent |
	
	aGrandparent := aRedBlackNode grandparent.
	aRedBlackNode parent beBlack.
	aGrandparent beRed.
	
	aRedBlackNode == aRedBlackNode parent left
		ifTrue: [ self rotateRight: aGrandparent tree: aRedBlackTree ]
		ifFalse: [ self rotateLeft: aGrandparent tree: aRedBlackTree ]
]

{ #category : #inserting }
TBlRedBlackTreeNode classSide >> insertedRedBlackFirst: aBlackRedNode tree: aRedBlackTree [
	"Case 1: The current node N is at the root of the tree.
	In this case, it is repainted black to satisfy property 2 (the root is black).
	Since this adds one black node to every path at once, property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) is not violated."
	
	aBlackRedNode hasParent
		ifTrue: [ self insertedRedBlackSecond: aBlackRedNode tree: aRedBlackTree ]
		ifFalse: [
			aBlackRedNode beBlack.
			aRedBlackTree root: aBlackRedNode ]
]

{ #category : #inserting }
TBlRedBlackTreeNode classSide >> insertedRedBlackForth: aRedBlackNode tree: aRedBlackTree [
	"Case 4: The parent P is red but the uncle U is black; also, the current node N is the right child of P, and P in turn is the left child of its parent G. In this case, a left rotation on P that switches the roles of the current node N and its parent P can be performed; then, the former parent node P is dealt with using case 5 (relabeling N and P) because property 4 (both children of every red node are black) is still violated. The rotation causes some paths (those in the sub-tree labelled '1') to pass through the node N where they did not before. It also causes some paths (those in the sub-tree labelled '3') not to pass through the node P where they did before. However, both of these nodes are red, so property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) is not violated by the rotation. After this case has been completed, property 4 (both children of every red node are black) is still violated, but now we can resolve this by continuing to case 5."
	| aGrandparent aCurrentNode |
	
	aCurrentNode := aRedBlackNode.
	
	self
		assert: [ aCurrentNode hasGrandparent ]
		description: [ 'A node must have a grandparent!' ].
	
	aGrandparent := aCurrentNode grandparent.
	
	(aCurrentNode == aCurrentNode parent right and: [ aCurrentNode parent == aGrandparent left ])
		ifTrue: [
			self rotateLeft: aCurrentNode parent tree: aRedBlackTree.
			aCurrentNode := aCurrentNode left ]
		ifFalse: [ (aCurrentNode == aCurrentNode parent left and: [ aCurrentNode parent == aGrandparent right ])
			ifTrue: [
				self rotateRight: aCurrentNode parent tree: aRedBlackTree.
				aCurrentNode := aCurrentNode right ] ].
	
	self insertedRedBlackFifth: aCurrentNode tree: aRedBlackTree
]

{ #category : #inserting }
TBlRedBlackTreeNode classSide >> insertedRedBlackSecond: aRedBlackNode tree: aRedBlackTree [
	"Case 2: The current node's parent P is black, so property 4 (both children of every red node are black) is not invalidated.
	In this case, the tree is still valid.
	Property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) is not threatened,
	because the current node N has two black leaf children, but because N is red,
	the paths through each of its children have the same number of black nodes as the path through the leaf it replaced,
	which was black, and so this property remains satisfied."
	
	self
		assert: [ aRedBlackNode hasParent ]
		description: [ 'Case 2 is only valid if I have a parent' ].
	
	"Tree is still valid"
	aRedBlackNode parent isBlack
		ifTrue: [ ^ self ].
	
	self insertedRedBlackThird: aRedBlackNode tree: aRedBlackTree
]

{ #category : #inserting }
TBlRedBlackTreeNode classSide >> insertedRedBlackThird: aRedBlackNode tree: aRedBlackTree [
	"Case 3: If both the parent P and the uncle U are red, then both of them can be repainted black and the grandparent G becomes red (to maintain property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes)). Now, the current red node N has a black parent.
	Since any path through the parent or uncle must pass through the grandparent, the number of black nodes on these paths has not changed.
	However, the grandparent G may now violate properties 2 (The root is black) or 4 (Both children of every red node are black) (property 4 possibly being violated since G may have a red parent).
	To fix this, the entire procedure is recursively performed on G from case 1.
	Note that this is a tail-recursive call, so it could be rewritten as a loop; since this is the only loop, and any rotations occur after this loop, this proves that a constant number of rotations occur."
	| aGrandParent |
	
	(aRedBlackNode hasUncle not or: [ aRedBlackNode uncle isBlack ])
		ifTrue: [ ^ self insertedRedBlackForth: aRedBlackNode tree: aRedBlackTree ].
		
	aRedBlackNode parent beBlack.
	aRedBlackNode uncle beRed.
	
	aGrandParent := aRedBlackNode grandparent.
	aGrandParent beRed.
	self insertedRedBlackFirst: aGrandParent tree: aRedBlackTree
]

{ #category : #rotation }
TBlRedBlackTreeNode classSide >> rotateLeft: aRedBlackNode tree: aRedBlackTree [
	"Perform a left rotation of a given node in a tree according to
	Introduction to Algorithms p.313 by Thomas H. Cormen"
	| aRight |
	
	self
		assert: [ aRedBlackNode hasRight ]
		description: [ 'A node must have right node in order to be left rotated' ].
	
	aRight := aRedBlackNode right.
	aRedBlackNode right: aRight left.
	
	aRight hasLeft
		ifTrue: [ aRight left parent: aRedBlackNode ].
	aRight parent: aRedBlackNode parent.
	
	aRedBlackNode hasParent
		ifFalse: [ aRedBlackTree root: aRight ]
		ifTrue: [ aRedBlackNode == aRedBlackNode parent left
			ifTrue: [ aRedBlackNode parent left: aRight ]
			ifFalse: [ aRedBlackNode parent right: aRight ] ].
		
	aRight left: aRedBlackNode.
	aRedBlackNode parent: aRight
]

{ #category : #rotation }
TBlRedBlackTreeNode classSide >> rotateRight: aRedBlackNode tree: aRedBlackTree [
	"Perform a right rotation of a given node in a tree according to
	Introduction to Algorithms p.313 by Thomas H. Cormen"
	| aLeft |
	
	self
		assert: [ aRedBlackNode hasLeft ]
		description: [ 'A node must have right node in order to be left rotated' ].
	
	aLeft := aRedBlackNode left.
	aRedBlackNode left: aLeft right.
	
	aLeft hasRight
		ifTrue: [ aLeft right parent: aRedBlackNode ].
	aLeft parent: aRedBlackNode parent.
	
	aRedBlackNode hasParent
		ifFalse: [ aRedBlackTree root: aLeft ]
		ifTrue: [ aRedBlackNode == aRedBlackNode parent right
			ifTrue: [ aRedBlackNode parent right: aLeft ]
			ifFalse: [ aRedBlackNode parent left: aLeft ] ].
		
	aLeft right: aRedBlackNode.
	aRedBlackNode parent: aLeft
]

{ #category : #'tree - searching' }
TBlRedBlackTreeNode >> at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	aComparable = self key
		ifTrue: [ ^ aPresentBlock value: self ].
		
	^ aComparable < self key
		ifTrue: [ 
			self hasLeft
				ifTrue: [ self left at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock ]
				ifFalse: [ anAbsentBlock value ] ]
		ifFalse: [ 
			self hasRight
				ifTrue: [ self right at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock ]
				ifFalse: [ anAbsentBlock value ] ]
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> beBlack [
	"Make me a black node"

	self color: #black
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> beRed [
	"Make me a black node"

	self color: #red
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> color [
	"Return node color as a symbol. Can be #black or #red"
	<return: #Symbol>
	
	^ self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> color: aSymbol [
	"Set the color of this node. Can be #black or #red"
	
	self explicitRequirement
]

{ #category : #'tree - enumerating' }
TBlRedBlackTreeNode >> do: aBlock [
	self hasLeft
		ifTrue: [ self left do: aBlock ].
		
	aBlock value: self.
	
	self hasRight
		ifTrue: [ self right do: aBlock ]
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> grandparent [
	"Return my grandparent node.
	Note: You must always check if I have a grandparent before using me"
	<return: #TBlRedBlackTreeNode>
	
	self
		assert: [ self hasGrandparent ]
		description: [ 'I must have grandparent to return it' ].
		
	^ self parent parent
]

{ #category : #'tree - testing' }
TBlRedBlackTreeNode >> hasGrandparent [
	"Return true if I have a grandparent, false otherwise"
	<return: #Boolean>
	
	^ self hasParent and: [ self parent hasParent ]
]

{ #category : #'tree - testing' }
TBlRedBlackTreeNode >> hasLeft [
	"Return true if there is left node, false otherwise"
	<return: #Boolean>
	
	^ self left isNotNil
]

{ #category : #'tree - testing' }
TBlRedBlackTreeNode >> hasParent [
	"Return true if I have a parent, false otherwise"
	<return: #Boolean>
	
	^ self parent isNotNil
]

{ #category : #'tree - testing' }
TBlRedBlackTreeNode >> hasRight [
	"Return true if there is right node, false otherwise"
	<return: #Boolean>
	
	^ self right isNotNil
]

{ #category : #'tree - testing' }
TBlRedBlackTreeNode >> hasUncle [
	"Return true if I have a grandparent, false otherwise"
	<return: #Boolean>
	| aGrandparent |
	
	"no grandparent => no uncle"
	self hasGrandparent
		ifFalse: [ ^ self ].
		
	aGrandparent := self grandparent.
	
	^ self parent == aGrandparent left
		ifTrue: [ aGrandparent hasRight ]
		ifFalse: [ aGrandparent hasLeft ]
]

{ #category : #'private - inserting' }
TBlRedBlackTreeNode >> insertBinary: aRedBlackNode [
	"Insert a Node using classic binary search tree algorithm marking a new added node as RED"

	"Mark it as red"
	aRedBlackNode beRed.

	aRedBlackNode key < self key
		ifTrue: [
			self hasLeft
				ifTrue: [ self left insertBinary: aRedBlackNode ]
				ifFalse: [
					self left: aRedBlackNode.
					aRedBlackNode parent: self ] ]
		ifFalse: [
			self hasRight
				ifTrue: [ self right insertBinary: aRedBlackNode ]
				ifFalse: [
					self right: aRedBlackNode.
					aRedBlackNode parent: self ] ]
]

{ #category : #'tree - testing' }
TBlRedBlackTreeNode >> isBlack [
	"Return true if I am a black node, false otherwise"
	<return: #Boolean>
	
	^ self color = #black
]

{ #category : #'tree - testing' }
TBlRedBlackTreeNode >> isRed [
	"Return true if I am a red node, false otherwise"
	<return: #Boolean>
	
	^ self color = #red
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> key [
	"Return a comparable object that understands `<` and `>` playing a role of a Key"
	<return: #TComparable>
	
	^ self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> left [
	"Return a left red-black node"
	<return: #TBlRedBlackTreeNode>
	
	^ self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> left: aRedBlackNode [
	"Set my left node to a given one"
	
	self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> parent [
	"Return a parent red-black node"
	<return: #TBlRedBlackTreeNode>
	
	^ self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> parent: aRedBlackTreeNode [
	"Assign a given node as my parent.
	aRedBlackTreeNode must not be nil"

	self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> right [
	"Return a right red-black node"
	<return: #TBlRedBlackTreeNode>
	
	^ self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> right: aRedBlackNode [
	"Set my right node to a given one"
	
	self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTreeNode >> uncle [
	"Return my uncle node. I have uncle if I have a grandparent which has left or right nodes
	Note: Always use #hasUncle before using me"
	<return: #TBlRedBlackTreeNode>
	| aGrandparent |
	
	self
		assert: [ self hasUncle ]
		description: [ 'I must have an uncle in order to return it' ].
		
	aGrandparent := self grandparent.
	
	^ self parent == aGrandparent left
		ifTrue: [ aGrandparent right ]
		ifFalse: [ aGrandparent left ]
]
