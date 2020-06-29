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
	#category : #'Bloc-DataStructure - Rope'
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

{ #category : #'rope - attributes' }
BlConcatenationRope >> attributes: anAttributesCollection from: aStart to: anEnd [
	| leftSize newLeft newRight |

	self assertAccessFrom: aStart to: anEnd.
	
	anAttributesCollection
		ifEmpty: [ ^ self ].

	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ self class attributeRope
			attributes: anAttributesCollection
			rope: self ].

	leftSize := left size.
	newLeft := nil.
	newRight := nil.

	newLeft := anEnd <= leftSize
		ifTrue: [ left attributes: anAttributesCollection from: aStart to: anEnd ]
		ifFalse: [ aStart < leftSize
			ifTrue: [ left attributes: anAttributesCollection from: aStart to: leftSize ]
			ifFalse: [ left ] ].

	newRight := aStart >= leftSize
		ifTrue: [ right attributes: anAttributesCollection from: aStart - leftSize to: anEnd - leftSize ]
		ifFalse: [ anEnd > leftSize
			ifTrue: [ right attributes: anAttributesCollection from: 0 to: anEnd - leftSize ]
			ifFalse: [ right ] ].
		
	^ self class
		concatenate: newLeft
		and: newRight
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> children [
	^ { left . right }
]

{ #category : #'rope - attributes' }
BlConcatenationRope >> clearAttributes: aStart to: anEnd if: aBlock [
	| leftSize newLeft newRight |
	
	self assertAccessFrom: aStart to: anEnd.
	
	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [
			| aNewLeft aNewRight |
			
			aNewLeft := left clearAttributes: 0 to: left size if: aBlock.
			aNewRight := right clearAttributes: 0 to: right size if: aBlock.
			
			^ (left == aNewLeft and: [ right == aNewRight ])
				ifTrue: [ self ]
				ifFalse: [
					self class
						concatenate: aNewLeft
						and: aNewRight ] ].

	leftSize := left size.
	newLeft := nil.
	newRight := nil.

	newLeft := anEnd <= leftSize
		ifTrue: [ left clearAttributes: aStart to: anEnd if: aBlock ]
		ifFalse: [ aStart < leftSize
			ifTrue: [ left clearAttributes: aStart to: leftSize if: aBlock ]
			ifFalse: [ left ] ].

	newRight := aStart >= leftSize
		ifTrue: [ right clearAttributes: aStart - leftSize to: anEnd - leftSize if: aBlock ]
		ifFalse: [ anEnd > leftSize
			ifTrue: [ right clearAttributes: 0 to: anEnd - leftSize if: aBlock ]
			ifFalse: [ right ] ].

	^ (left == newLeft and: [ right == newRight ])
		ifTrue: [ self ]
		ifFalse: [
			self class
				concatenate: newLeft
				and: newRight ]
]

{ #category : #copying }
BlConcatenationRope >> copyFrom: startIndex to: endIndex [

	^ self from: startIndex-1 to: endIndex
]

{ #category : #'rope - deleting' }
BlConcatenationRope >> delete: aStart to: anEnd [
	self assertAccessFrom: aStart to: anEnd.

	"We remove the whole left side, just return the right one"
	(aStart = 0 and: [ anEnd = left size ])
		ifTrue: [ ^ right ].
		
	"We remove the whole right side, just return the left one"
	(aStart = left size and: [ anEnd = self size ])
		ifTrue: [ ^ left ].

	^ (aStart > 0 and: [ anEnd < self size ])
		ifTrue: [
			self class
				concatenate: (self from: 0 to: aStart)
				and: (self from: anEnd to: self size) ]
		ifFalse: [
			(aStart = 0 and: [ anEnd = self size ])
				ifTrue: [ self empty ]
				ifFalse: [ aStart = 0
					ifTrue: [ self from: anEnd to: self size ]
					ifFalse: [ self from: 0 to: aStart ] ] ]
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> depth [
	<return: #Number>

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

	self assertAccessFrom: aStart to: anEnd.

	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	leftSize := left size.
	anEnd <= leftSize
		ifTrue: [ ^ left from: aStart to: anEnd ].

	aStart >= leftSize
		ifTrue: [ ^ right from: aStart - leftSize to: anEnd - leftSize ].

	^ self class
		concatenate: (left from: aStart to: leftSize)
		and: (right from: 0 to: anEnd - leftSize)
]

{ #category : #'rope - enumeration' }
BlConcatenationRope >> from: aStart to: anEnd do: aBlock [
	| leftSize isReversed |
	
	self assertAccessFrom: aStart to: anEnd.
	
	leftSize := left size.
	isReversed := anEnd < aStart.
	
	isReversed
		ifTrue: [
			aStart > leftSize
				ifTrue: [ right from: aStart - leftSize to: (anEnd max: leftSize + 1) - leftSize do: aBlock ].
			anEnd <= leftSize
				ifTrue: [ left from: (aStart min: leftSize) to: anEnd do: aBlock ] ]
		ifFalse: [ 
			aStart < leftSize
				ifTrue: [ left from: aStart to: (anEnd min: leftSize) do: aBlock ].
			anEnd > leftSize
				ifTrue: [ right from: ((aStart - leftSize) max: 0) to: anEnd - leftSize do: aBlock ] ]
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
	<return: #BlRope>

	^ left
]

{ #category : #initialization }
BlConcatenationRope >> left: aLeftRope right: aRightRope [
	left := aLeftRope.
	right := aRightRope.
	length := left size + right size
]

{ #category : #'text - converting' }
BlConcatenationRope >> normalized [
	<return: #BlRope>

	^ self class
		concatenate: left normalized
		and: right normalized
]

{ #category : #accessing }
BlConcatenationRope >> readStream [ 

	^ ReadStream on: self
]

{ #category : #'rope - replacing' }
BlConcatenationRope >> replaceFrom: aStart to: anEnd with: aCollection [
	"Replace a piece of the rope with a given collection of items"
	<return: #BlRope>
	| leftSize |
	self assertAccessFrom: aStart to: anEnd.
	
	aStart = anEnd
		ifTrue: [ ^ self ].

	aCollection
		ifEmpty: [ ^ self ].

	leftSize := left size.
	
	"we only replace something in the left part"
	anEnd <= leftSize
		ifTrue: [
			^ self class
				concatenate: (left replaceFrom: aStart to: anEnd with: aCollection )
				and: right ].

	"we only replace something in the right part"
	aStart >= leftSize
		ifTrue: [
			^ self class
				concatenate: left
				and: (right replaceFrom: aStart - leftSize to: anEnd - leftSize with: aCollection) ].
	
	"there is nothing else we can do except falling back to the primitive algorithm"
	^ (self delete: aStart to: anEnd) insertItems: aCollection at: aStart
]

{ #category : #accessing }
BlConcatenationRope >> right [
	<return: #BlRope>

	^ right
]

{ #category : #'rope - replacing' }
BlConcatenationRope >> simplified [
	<return: #BlRope>

	^ self class
		concatenate: left simplified
		and: right simplified
]

{ #category : #'rope - accessing' }
BlConcatenationRope >> size [
	^ length
]
