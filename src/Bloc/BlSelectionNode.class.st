"
I represent a single node within interval tree `=BlTextSelectionTree`=.

I am a binary node with `=selection`= playing a role of a key (lowest value) and value. Additionally I cache the highest interval value of a subtree including my own interval.

"
Class {
	#name : #BlSelectionNode,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'left',
		'right',
		'selection',
		'high',
		'parent'
	],
	#category : #'Bloc-Utilities - Selection'
}

{ #category : #'instance creation' }
BlSelectionNode class >> selection: aMonotoneTextSelection [
	^ self new selection: aMonotoneTextSelection
]

{ #category : #comparing }
BlSelectionNode >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	self hasRight = anObject hasRight
		ifFalse: [ ^ false ].

	(self hasRight and: [ self right ~= anObject right ])
		ifTrue: [ ^ false ].
		
	self hasLeft = anObject hasLeft
		ifFalse: [ ^ false ].
		
	(self hasLeft and: [ self left ~= anObject left ])
		ifTrue: [ ^ false ].
		
	self high = anObject high
		ifFalse: [ ^ false ].
		
	self selection = anObject selection
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
BlSelectionNode >> children [
	"Return a collection of children selection nodes"
	<return: #Array of: #BlSelectionNode>
	
	^ Array streamContents: [ :aStream |
		self hasLeft
			ifTrue: [ aStream nextPut: self left ].
		self hasRight
			ifTrue: [ aStream nextPut: self right ] ]
]

{ #category : #'tree - testing' }
BlSelectionNode >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"

	anIndex > self high
		ifTrue: [ ^ false ].
		
	(self selection contains: anIndex)
		ifTrue: [ ^ true ].
		
	(self hasLeft and: [ anIndex <= self left high ])
		ifTrue: [ ^ self left contains: anIndex ].
		
	(self hasRight and: [ anIndex <= self right high ])
		ifTrue: [ ^ self right contains: anIndex ].
		
	^ false
]

{ #category : #'tree - testing' }
BlSelectionNode >> containsIndex: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"

	anIndex > self high
		ifTrue: [ ^ false ].
		
	(self selection containsIndex: anIndex)
		ifTrue: [ ^ true ].
		
	(self hasLeft and: [ anIndex <= self left high ])
		ifTrue: [ ^ self left containsIndex: anIndex ].
		
	(self hasRight and: [ anIndex <= self right high ])
		ifTrue: [ ^ self right containsIndex: anIndex ].
		
	^ false
]

{ #category : #'tree - testing' }
BlSelectionNode >> containsMonotoneSelection: aSelection [
	"Return true if selection interval include a given interval, false otherwise. "

	aSelection from > self high ifTrue: [ ^ false ].

	(self selection containsMonotoneSelection: aSelection) ifTrue: [
		^ true ].

	(self hasLeft and: [ aSelection to <= self left high ]) ifTrue: [
		^ self left containsMonotoneSelection: aSelection ].

	self hasRight ifTrue: [
		^ self right containsMonotoneSelection: aSelection ].

	^ false
]

{ #category : #'instance creation' }
BlSelectionNode >> createNode: aSelection [
	^ (self class selection: aSelection)
		parent: self;
		yourself
]

{ #category : #'tree - deletion' }
BlSelectionNode >> delete [
	"Delete me from the tree"

	(self hasLeft and: [ self hasRight ])
		ifTrue: [ 
			| successorNode |
			successorNode := self right findMin.
			selection := successorNode selection.
			successorNode delete ]
		ifFalse: [ 
			self hasLeft
				ifTrue: [ self replaceInParent: self left ]
				ifFalse: [ self hasRight
					ifTrue: [ self replaceInParent: self right ]
					ifFalse: [ self deleteInParent ] ] ]
]

{ #category : #'tree - deletion' }
BlSelectionNode >> deleteInParent [
	"Delete me from the parent"
	self
		assert: [ self hasLeft not and: [ self hasRight not ] ]
		description: [ 'I can not be deleted from the parent if I have children' ].
	
	(self hasParent and: [ self parent isRoot not ])
		ifTrue: [			
			(self parent hasLeft and: [ self parent left == self ])
				ifTrue: [ self parent removeLeft ].
			(self parent hasRight and: [ self parent right == self ])
				ifTrue: [ self parent removeRight ] ].
	
	(self hasParent and: [ self parent isRoot ])
		ifTrue: [ self parent removeRoot ].
	
	"I am deleted and don't have a parent anymore"
	parent := nil
]

{ #category : #'tree - enumerating' }
BlSelectionNode >> do: aBlock [
	self hasLeft
		ifTrue: [ self left do: aBlock ].
		
	aBlock value: self selection.
	
	self hasRight
		ifTrue: [ self right do: aBlock ]
]

{ #category : #'tree - searching' }
BlSelectionNode >> findMax [
	"Return a minimum node in a subtree"
	<return: #BlSelectionNode>
	| aCurrentNode |
	
	aCurrentNode := self.
	[ aCurrentNode hasRight ]
		whileTrue: [ aCurrentNode := aCurrentNode right ].
	^ aCurrentNode
]

{ #category : #'tree - searching' }
BlSelectionNode >> findMin [
	"Return a minimum node in a subtree"
	<return: #BlSelectionNode>
	| aCurrentNode |
	
	aCurrentNode := self.
	[ aCurrentNode hasLeft ]
		whileTrue: [ aCurrentNode := aCurrentNode left ].
	^ aCurrentNode
]

{ #category : #'tree - testing' }
BlSelectionNode >> hasLeft [
	^ left isNotNil
]

{ #category : #'tree - testing' }
BlSelectionNode >> hasParent [
	^ parent isNotNil
]

{ #category : #'tree - testing' }
BlSelectionNode >> hasRight [
	^ right isNotNil
]

{ #category : #accessing }
BlSelectionNode >> high [
	^ high
]

{ #category : #'tree - inserting' }
BlSelectionNode >> insert: aMonotoneTextSelection [

	aMonotoneTextSelection < self selection
		ifTrue: [
			left
				ifNil: [ left := self createNode: aMonotoneTextSelection ]
				ifNotNil: [ left insert: aMonotoneTextSelection ] ]
		ifFalse: [ 
			right
				ifNil: [ right := self createNode: aMonotoneTextSelection ]
				ifNotNil: [ right insert: aMonotoneTextSelection ] ].
	high := high max: ((left ifNil: [ 0 ] ifNotNil: #high) max: (right ifNil: [ 0 ] ifNotNil: #high))
]

{ #category : #'tree - testing' }
BlSelectionNode >> isRoot [
	^ false
]

{ #category : #accessing }
BlSelectionNode >> left [
	self
		assert: [ left isNotNil ]
		description: [ 'You can not access `left` if it does not exist. Check #hasLeft first!' ].
	
	^ left
]

{ #category : #accessing }
BlSelectionNode >> left: aTextSelectionNode [
	
	left := aTextSelectionNode
]

{ #category : #'tree - searching' }
BlSelectionNode >> overlapping: aMonotoneTextSelection in: aStream [
	
	(left isNotNil and: [ aMonotoneTextSelection from <= left high ])
		ifTrue: [ left overlapping: aMonotoneTextSelection in: aStream ].

	(self selection overlaps: aMonotoneTextSelection)
		ifTrue: [ aStream nextPut: self ].

	(right isNotNil and: [ aMonotoneTextSelection from <= right high ])
		ifTrue: [ right overlapping: aMonotoneTextSelection in: aStream ]
]

{ #category : #'tree - searching' }
BlSelectionNode >> overlappingNeighbours: aMonotoneTextSelection in: aStream [
	
	(left isNotNil and: [ aMonotoneTextSelection from <= (left high + 1) ])
		ifTrue: [ left overlappingNeighbours: aMonotoneTextSelection in: aStream ].

	((self selection overlaps: aMonotoneTextSelection) or: [ self selection neighbours: aMonotoneTextSelection ])
		ifTrue: [ aStream nextPut: self ].

	(right isNotNil and: [ aMonotoneTextSelection from <= (right high + 1) ])
		ifTrue: [ right overlappingNeighbours: aMonotoneTextSelection in: aStream ]
]

{ #category : #accessing }
BlSelectionNode >> parent [
	self
		assert: [ parent isNotNil ]
		description: [ 'You can not access `parent` if it does not exist. Check #hasParent first!' ].
		
	^ parent
]

{ #category : #accessing }
BlSelectionNode >> parent: aBlSelectionNode [
	parent := aBlSelectionNode
]

{ #category : #copying }
BlSelectionNode >> postCopy [
	right := right copy.
	right ifNotNil: [ right parent: self ].
	
	left := left copy.
	left ifNotNil: [ left parent: self ].
	
	high := high copy.
	selection := selection copy
	
	
	
]

{ #category : #printing }
BlSelectionNode >> printOn: aStream [

	self hasLeft ifTrue: [ self left printOn: aStream ].
	self selection printOn: aStream.
	self hasRight ifTrue: [ self right printOn: aStream ].
]

{ #category : #'tree - deletion' }
BlSelectionNode >> removeLeft [
	left := nil
]

{ #category : #'tree - deletion' }
BlSelectionNode >> removeRight [
	right := nil
]

{ #category : #'tree - deletion' }
BlSelectionNode >> replaceInParent: aTextSelectionNode [
	"Replace me in a parent with a given node"
	
	(self hasParent and: [ self parent isRoot not ])
		ifTrue: [			
			(self parent hasLeft and: [ self parent left == self ])
				ifTrue: [ self parent left: aTextSelectionNode ].
			(self parent hasRight and: [ self parent right == self ])
				ifTrue: [ self parent right: aTextSelectionNode ] ].
	
	(self hasParent and: [ self parent isRoot ])
		ifTrue: [ self parent root: aTextSelectionNode ].
	
	aTextSelectionNode parent: self parent.
	"I am replaced and don't have a parent anymore"
	parent := nil
]

{ #category : #'tree - enumerating' }
BlSelectionNode >> reverseDo: aBlock [

	self hasRight
		ifTrue: [ self right reverseDo: aBlock ].
	
	aBlock value: self selection.
	
	self hasLeft
		ifTrue: [ self left reverseDo: aBlock ]
]

{ #category : #accessing }
BlSelectionNode >> right [
	self
		assert: [ right isNotNil ]
		description: [ 'You can not access `right` if it does not exist. Check #hasRight first!' ].
	
	^ right
]

{ #category : #accessing }
BlSelectionNode >> right: aTextSelectionNode [
	
	right := aTextSelectionNode
]

{ #category : #accessing }
BlSelectionNode >> selection [
	^ selection
]

{ #category : #initialization }
BlSelectionNode >> selection: aMonotoneTextSelection [
	selection := aMonotoneTextSelection.
	high := selection to
]
