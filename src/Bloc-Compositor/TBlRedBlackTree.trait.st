"
I am a Red-Black tree https://en.wikipedia.org/wiki/Red–black_tree

In addition to the requirements imposed on a binary search tree the following must be satisfied by a red–black tree:

1) Each node is either red or black.
2) The root is black. This rule is sometimes omitted. Since the root can always be changed from red to black, but not necessarily vice versa, this rule has little effect on analysis.
3) All leaves (NIL) are black.
4) If a node is red, then both its children are black.
5) Every path from a given node to any of its descendant NIL nodes contains the same number of black nodes. Some definitions: the number of black nodes from the root to a node is the node's black depth; the uniform number of black nodes in all paths from root to the leaves is called the black-height of the red–black tree.
"
Trait {
	#name : #TBlRedBlackTree,
	#category : 'Bloc-Compositor-Red-Black Tree'
}

{ #category : #'tree - searching' }
TBlRedBlackTree >> at: aComparable [ 
	"Answer the value associated with the key."

	^ self at: aComparable ifAbsent: [ self errorKeyNotFound: aComparable ]
]

{ #category : #'tree - searching' }
TBlRedBlackTree >> at: aComparable ifAbsent: aBlock [ 
	"Answer the property value or pragma associated with aKey or,
	 if aKey isn't found, answer the result of evaluating aBlock."

	^ self
		at: aComparable
		ifPresent: #yourself
		ifAbsent: [ aBlock value ]
]

{ #category : #'tree - searching' }
TBlRedBlackTree >> at: aComparable ifAbsentPut: anAbsentBlock [
		
	^ self
		at: aComparable
		ifAbsent: [
			| aNode |
			aNode := anAbsentBlock value.
			self insert: aNode.
			aNode ]
]

{ #category : #'tree - searching' }
TBlRedBlackTree >> at: aComparable ifPresent: aPresentBlock [

	^ self
		at: aComparable
		ifPresent: aPresentBlock
		ifAbsent: nil
]

{ #category : #'tree - searching' }
TBlRedBlackTree >> at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self hasRoot
		ifFalse: [ anAbsentBlock value ]
		ifTrue: [ self root at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock ]
]

{ #category : #'tree - searching' }
TBlRedBlackTree >> at: aComparable ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
		
	^ self
		at: aComparable
		ifPresent: aPresentBlock
		ifAbsent: [
			| aNode |
			aNode := anAbsentBlock value.
			self insert: aNode.
			aNode ]
]

{ #category : #'tree - enumerating' }
TBlRedBlackTree >> do: aBlock [
	self hasRoot
		ifTrue: [ self root do: aBlock ]
]

{ #category : #private }
TBlRedBlackTree >> errorKeyNotFound: aKey [

	KeyNotFound signalFor: aKey
]

{ #category : #'tree - testing' }
TBlRedBlackTree >> hasRoot [
	"Return true if I have a root node (meaning that there is at least one added node),
	fasle otherwise"
	<return: #Boolean>
	
	^ self root isNotNil
]

{ #category : #'tree - inserting' }
TBlRedBlackTree >> insert: aRedBlackNode [
	"Insert a given node in red-black tree balancing the latter"

	self hasRoot
		ifTrue: [ self root insertBinary: aRedBlackNode ]
		ifFalse: [ self root: aRedBlackNode ].
		
	aRedBlackNode class insertedRedBlackFirst: aRedBlackNode tree: self
]

{ #category : #'tree - accessing' }
TBlRedBlackTree >> root [
	"Return my root node"
	<return: #TBlRedBlackTreeNode>
	
	^ self explicitRequirement
]

{ #category : #'tree - accessing' }
TBlRedBlackTree >> root: aRedBlackNode [
	"Change my root node to the given one"
	
	self explicitRequirement
]
