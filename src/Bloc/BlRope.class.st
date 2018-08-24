"
A rope is a binary tree having leaf nodes that contain a short string. Each node has a weight value equal to the length of its string plus the sum of all leaf nodes' weight in its left subtree, namely the weight of a node is the total string length in its left subtree for a non-leaf node, or the string length of itself for a leaf node. Thus a node with two children divides the whole string into two parts: the left subtree stores the first part of the string. The right subtree stores the second part and its weight is the sum of the left child's weight and the length of its contained string.
The binary tree can be seen as several levels of nodes. The bottom level contains all the nodes that contain a string. Higher levels have fewer and fewer nodes. The top level consists of a single ""root"" node. The rope is built by putting the nodes with short strings in the bottom level, then attaching a random half of the nodes to parent nodes in the next level.

I can be enumerated with the help of BlRopeIterator.

https://en.wikipedia.org/wiki/Rope_(data_structure)




"
Class {
	#name : #BlRope,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #types }
BlRope class >> attributeRope [
	^ BlAttributeRope
]

{ #category : #types }
BlRope class >> collectionRope [
	^ BlCollectionRope
]

{ #category : #accessing }
BlRope class >> combineLength [
	^ 32
]

{ #category : #rope }
BlRope class >> concatenate: aLeftRope and: aRightRope [
	| totalSize |
	aLeftRope isEmpty
		ifTrue: [ ^ aRightRope ].

	aRightRope isEmpty 
		ifTrue: [ ^ aLeftRope ].

	totalSize := aLeftRope size + aRightRope size.
	
	"if both ropes are leafs we can simplify concatenation"
	(aLeftRope isLeaf and: [ aRightRope isLeaf ])
		ifTrue: [ 
			^ totalSize <= self combineLength
				ifTrue: [ self collectionRope from: aLeftRope and: aRightRope ]
				ifFalse: [ self concatenationRope left: aLeftRope right: aRightRope ] ].

	"left rope is not concatenation while right is"
	(aLeftRope isConcatenation not and: [ aRightRope isConcatenation ])
		ifTrue: [ 
			| newLeft |
			newLeft := self concatenate: aLeftRope and: aRightRope left.
			^ newLeft isConcatenation
				ifTrue: [ self concatenationRope left: newLeft right: aRightRope right ]
				ifFalse: [ self concatenate: newLeft and: aRightRope right ] ].

	"right rope is not concatenation while left is"
	(aRightRope isConcatenation not and: [ aLeftRope isConcatenation ])
		ifTrue: [ 
			| newRight |
			newRight := self concatenate: aLeftRope right and: aRightRope.
			^ newRight isConcatenation
				ifTrue: [ self concatenationRope left: aLeftRope left right: newRight ]
				ifFalse: [ self concatenate: aLeftRope left and: newRight ] ].
	
	((aLeftRope size + aRightRope size > (self combineLength)) and: [ (aLeftRope size * 2) < aRightRope size ])
		ifTrue: [ 
			| aMiddle |
			aMiddle := ((aLeftRope size + aRightRope size) / 2.0) floor asInteger - aLeftRope size.
			^ self concatenationRope
				left: (aLeftRope append: (aRightRope from: 1 to: aMiddle))
				right: (aRightRope from: aMiddle + 1 to: aRightRope size) ].
	
	
	^ self concatenationRope left: aLeftRope right: aRightRope
]

{ #category : #types }
BlRope class >> concatenationRope [
	^ BlConcatenationRope
]

{ #category : #types }
BlRope class >> subRope [
	^ BlSubRope
]

{ #category : #'rope - accessing' }
BlRope >> append: aRope [
	"Create and return a new rope by append a given rope to the of end of me"
	<return: #BlRope>

	^ self class concatenate: self and: aRope
]

{ #category : #converting }
BlRope >> asString [
	^ self printStringLimitedTo: Float infinity
]

{ #category : #'private - asserting' }
BlRope >> assertAccess: anIndex [
	"I am an index invariant; I make sure that rope operation that require
	access by index do not go out of rope bounds"

	anIndex isNil
		ifTrue: [ self error: 'Illegal nil sub-sequence index value' ].
	anIndex < 1
		ifTrue: [ self error: 'Illegal sub-sequence start index: ', anIndex asString ].
	anIndex > self size
		ifTrue: [ self error: 'Illegal sub-sequence end index: ', anIndex asString ]
]

{ #category : #'private - asserting' }
BlRope >> assertAccessFrom: aStartIndex to: anEndIndex [
	"I am an index invariant; I make sure that rope operation that require
	access by index do not go out of rope bounds"

	(aStartIndex <= anEndIndex)
		ifFalse: [ self error: 'Start index must be less or equal to an end index' ].

	(aStartIndex isZero and: [ anEndIndex isZero ])
		ifTrue: [ ^ self ].

	self assertAccess: aStartIndex.
	self assertAccess: anEndIndex
]

{ #category : #'private - asserting' }
BlRope >> assertIndexForInsert: anIndex [
	"I am an insertion index invariant; I make sure that insertion operations
	do not go out of rope bounds"
	
	(anIndex < 0 or: [ anIndex > self size ])
		ifTrue: [ self error: 'Insert index ', anIndex asString, ' is out of bounds' ]
]

{ #category : #'rope - accessing' }
BlRope >> at: anIndex [
	"Return an item at an given index"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #'rope - accessing' }
BlRope >> attributes: anAttributesCollection [
	^ self attributes: anAttributesCollection from: (1 min: self size) to: self size
]

{ #category : #'rope - accessing' }
BlRope >> attributes: anAttributesCollection from: aStart to: anEnd [
	^ self subclassResponsibility
]

{ #category : #'rope - accessing' }
BlRope >> children [
	^ {  }
]

{ #category : #'rope - accessing' }
BlRope >> clearAttributes: aStart to: anEnd [
	"Clear all attributes"

	^ self clearAttributes: aStart to: anEnd if: [ :each | true ]
]

{ #category : #'rope - accessing' }
BlRope >> clearAttributes: aStart to: anEnd if: aBlock [
	^ self subclassResponsibility
]

{ #category : #'rope - deleting' }
BlRope >> delete: aStart to: anEnd [
	self subclassResponsibility
]

{ #category : #'rope - accessing' }
BlRope >> depth [
	"Return the max tree height of this rope (composition depth)"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'rope - enumeration' }
BlRope >> do: aBlock [
	self from: 1 to: self size do: aBlock
]

{ #category : #'rope - enumeration' }
BlRope >> empty [
	"Create and return an empty version of this rope"
	<return: #BlRope>
	
	^ self subclassResponsibility
]

{ #category : #'rope - accessing' }
BlRope >> from: aStart to: anEnd [
	^ self subclassResponsibility
]

{ #category : #'rope - enumeration' }
BlRope >> from: aStart to: anEnd do: aBlock [
	self subclassResponsibility
]

{ #category : #'rope - inserting' }
BlRope >> insert: aRope at: anIndex [
	"Insert aRope after anIndex"
	anIndex = 0
		ifTrue: [ ^ aRope append: self ].

	anIndex = self size
		ifTrue: [ ^ self append: aRope ].
		
	(anIndex < 0 or: [ anIndex > self size ])
		ifTrue: [ self error: 'Insert index ', anIndex asString, ' is out of bounds' ].

	^ ((self from: 1 to: anIndex) append: aRope) append: (self from: anIndex + 1 to: self size)
]

{ #category : #'rope - inserting' }
BlRope >> insertItems: aCollection at: anIndex [
	^ self subclassResponsibility
]

{ #category : #'rope - testing' }
BlRope >> isConcatenation [
	^ false
]

{ #category : #'rope - testing' }
BlRope >> isEmpty [
	"Return true if rope is empty, false otherwise"
	<return: #Boolean>

	^ self size isZero
]

{ #category : #'rope - testing' }
BlRope >> isLeaf [
	^ self subclassResponsibility
]

{ #category : #'rope - testing' }
BlRope >> isNotEmpty [
	"Return true if rope is not empty, false otherwise"
	<return: #Boolean>

	^ self size isZero not
]

{ #category : #'rope - enumeration' }
BlRope >> iterator [
	^ self iterator: (1 min: self size) to: self size
]

{ #category : #'rope - enumeration' }
BlRope >> iterator: aStart to: anEnd [
	^ self subclassResponsibility
]

{ #category : #'rope - accessing' }
BlRope >> last [
	^ self at: self size
]

{ #category : #'rope - printing' }
BlRope >> printOn: aStream [
	
	self do: [ :anItem | anItem isCharacter
		ifTrue: [ aStream nextPut: anItem ]
		ifFalse: [ aStream nextPutAll: anItem asString ] ]
]

{ #category : #'rope - streaming' }
BlRope >> putOn: aStream [
	self putOn: aStream from: 1 to: self size
]

{ #category : #'rope - streaming' }
BlRope >> putOn: aStream from: aStart to: anEnd [
	self from: aStart to: anEnd do: [ :anItem | aStream nextPut: anItem ]
]

{ #category : #'rope - accessing' }
BlRope >> size [
	<return: #Number>

	^ self subclassResponsibility
]
