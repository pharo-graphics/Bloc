"
I am a special type of rope that plays a role of a node in a binary tree and contains left and right branch
"
Class {
	#name : #BlConcatenationRope,
	#superclass : #BlRope,
	#instVars : [
		'left',
		'right',
		'length'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #'instance creation' }
BlConcatenationRope class >> left: aLeftRope right: aRightRope [
	^ self new
		left: aLeftRope right: aRightRope;
		yourself
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> at: anIndex [
	| leftSize |
	
	leftSize := left size.

	^ anIndex <= leftSize
		ifTrue: [ left at: anIndex ]
		ifFalse: [ right at: anIndex - leftSize ]
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> attributes: anAttributesCollection from: aStart to: anEnd [
	| leftSize newLeft newRight |
	self assertAccess: aStart.
	self assertAccess: anEnd.
	
	anAttributesCollection
		ifEmpty: [ ^ self ].

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self class attributeRope
			attributes: anAttributesCollection
			rope: self ].

	leftSize := left size.
	newLeft := nil.
	newRight := nil.

	newLeft := anEnd <= leftSize
		ifTrue: [ left attributes: anAttributesCollection from: aStart to: anEnd ]
		ifFalse: [ aStart <= leftSize
			ifTrue: [ left attributes: anAttributesCollection from: aStart to: leftSize ]
			ifFalse: [ left ] ].

	newRight := aStart > leftSize
		ifTrue: [ right attributes: anAttributesCollection from: aStart - leftSize to: anEnd - leftSize ]
		ifFalse: [ anEnd > leftSize
			ifTrue: [ right attributes: anAttributesCollection from: 1 to: anEnd - leftSize ]
			ifFalse: [ right ] ].
		
	^ self class
		concatenate: newLeft
		and: newRight
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> children [
	^ { left . right }
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> clearAttributes: aStart to: anEnd if: aBlock [
	| leftSize newLeft newRight |
	self assertAccess: aStart.
	self assertAccess: anEnd.
	

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self class
			concatenate: (left clearAttributes: 1 to: left size if: aBlock)
			and: (right clearAttributes: 1 to: right size if: aBlock) ].

	leftSize := left size.
	newLeft := nil.
	newRight := nil.

	newLeft := anEnd <= leftSize
		ifTrue: [ left clearAttributes: aStart to: anEnd if: aBlock ]
		ifFalse: [ aStart <= leftSize
			ifTrue: [ left clearAttributes: aStart to: leftSize if: aBlock ]
			ifFalse: [ left ] ].

	newRight := aStart > leftSize
		ifTrue: [ right clearAttributes: aStart - leftSize to: anEnd - leftSize if: aBlock ]
		ifFalse: [ anEnd > leftSize
			ifTrue: [ right clearAttributes: 1 to: anEnd - leftSize if: aBlock ]
			ifFalse: [ right ] ].

	^ self class
		concatenate: newLeft
		and: newRight
]

{ #category : #'rope - deleting' }
BlConcatenationRope >> delete: aStart to: anEnd [
	self assertAccess: aStart.
	self assertAccess: anEnd.

	"We remove the whole left side, just return the right one"
	(aStart = 1 and: [ anEnd = left size ])
		ifTrue: [ ^ right ].
		
	"We remove the whole right side, just return the left one"
	(aStart = (left size + 1) and: [ anEnd = self size ])
		ifTrue: [ ^ left ].
	
	^ (aStart > 1 and: [ anEnd < self size ])
		ifTrue: [
			self class
				concatenate: (self from: 1 to: aStart - 1)
				and: (self from: anEnd + 1 to: self size) ]
		ifFalse: [
			(aStart <= 1 and: [ anEnd >= self size ])
				ifTrue: [ self empty ]
				ifFalse: [ aStart <= 1
					ifTrue: [ self from: anEnd + 1 to: self size ]
					ifFalse: [ self from: 1 to: aStart - 1 ] ] ]
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> depth [
	^ (left depth max: right depth) + 1
]

{ #category : #'rope - enumeration' }
BlConcatenationRope >> do: aBlock [
	left do: aBlock.
	right do: aBlock
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> empty [
	"Create and return an empty version of this rope"
	<return: #BlRope>
	
	^ self left empty
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> from: aStart to: anEnd [
	| leftSize |

	self assertAccess: aStart.
	self assertAccess: anEnd.

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	leftSize := left size.
	anEnd <= leftSize
		ifTrue: [ ^ left from: aStart to: anEnd ].

	aStart > leftSize
		ifTrue: [ ^ right from: aStart - leftSize to: anEnd - leftSize ].

	^ self class 
		concatenate: (left from: aStart to: leftSize)
		and: (right from: 1 to: anEnd - leftSize)
]

{ #category : #'rope - enumeration' }
BlConcatenationRope >> from: aStart to: anEnd do: aBlock [
	| leftSize isReversed |
	
	self assertAccess: aStart.
	self assertAccess: anEnd.
	
	leftSize := left size.
	isReversed := anEnd < aStart.
	
	isReversed
		ifTrue: [
			aStart > leftSize
				ifTrue: [ right from: aStart - leftSize to: (anEnd max: leftSize + 1) - leftSize do: aBlock ].
			anEnd <= leftSize
				ifTrue: [ left from: (aStart min: leftSize) to: anEnd do: aBlock ] ]
		ifFalse: [ 
			aStart <= leftSize
				ifTrue: [ left from: aStart to: (anEnd min: leftSize) do: aBlock ].
			anEnd > leftSize
				ifTrue: [ right from: (aStart max: leftSize + 1) - leftSize to: anEnd - leftSize do: aBlock ] ]
]

{ #category : #'rope - inserting' }
BlConcatenationRope >> insertItems: aCollection at: anIndex [
	| leftSize aNewLeft aNewRight |
	self assertIndexForInsert: anIndex.

	leftSize := left size.
	aNewLeft := left.
	aNewRight := right.
	
	anIndex <= leftSize
		ifTrue: [ aNewLeft := left insertItems: aCollection at: anIndex ].
	
	anIndex > leftSize
		ifTrue: [ aNewRight := right insertItems: aCollection at: anIndex - leftSize ].

	^ self class concatenate: aNewLeft and: aNewRight
]

{ #category : #'rope - testing' }
BlConcatenationRope >> isConcatenation [
	^ true
]

{ #category : #'rope - testing' }
BlConcatenationRope >> isLeaf [
	^ false
]

{ #category : #'rope - enumeration' }
BlConcatenationRope >> iterator: aStart to: anEnd [
	^ BlConcatenationRopeIterator rope: self from: aStart to: anEnd
]

{ #category : #accessing }
BlConcatenationRope >> left [
	^ left
]

{ #category : #initialization }
BlConcatenationRope >> left: aLeftRope right: aRightRope [
	left := aLeftRope.
	right := aRightRope.
	length := left size + right size
]

{ #category : #accessing }
BlConcatenationRope >> right [
	^ right
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> size [
	^ length
]
