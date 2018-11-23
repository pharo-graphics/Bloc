"
I am a special iterator used to iterate over collection rope
"
Class {
	#name : #BlCollectionRopeIterator,
	#superclass : #BlRopeIterator,
	#instVars : [
		'position'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #asserting }
BlCollectionRopeIterator >> assertInvariant [

	self
		assert: [ (start isZero and: [ end isZero and: [ position isZero ] ])
			or: [ start > 0 and: [ end > 0 and: [ start <= end and: [ position > 0 ] ] ] ] ]
		description: [ 'Start, end and position may only be zero at the same time,
			otherwise they all must be positive' ]
]

{ #category : #'iterator - accessing' }
BlCollectionRopeIterator >> attributes [
	^ #()
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ anExceptionBlock value
]

{ #category : #'iterator - testing' }
BlCollectionRopeIterator >> hasNext [
	"Return true if iterator is be able to return #next item in the rope, meaning that is
	didn't reached the end, false otherwise"
	<return: #Boolean>

	self assertInvariant.

	^ rope isNotEmpty
		and: [ (position <= rope size)
			and: [ position <= end
				"if position is 0 we have empty iterator"
				and: [ position > 0 ] ] ]
]

{ #category : #'iterator - testing' }
BlCollectionRopeIterator >> hasPrevious [
	^ (position >= 1) and: [ position >= start ]
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> next [
	| anItem aPosition |	
	position >= 0
		ifFalse: [ self error: 'Index out of bounds: ', position asString ].
	
	aPosition := position max: 1.
	
	anItem := rope collection at: aPosition.
	position := aPosition + 1.

	^ anItem
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> nextSpan [
	| run |
	run := rope from: (position max: 1) to: end.
	position := end + 1.
	^ run
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> peek [
	^ rope collection at: position
]

{ #category : #'iterator - accessing' }
BlCollectionRopeIterator >> position [
	^ position
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> previous [
	| anItem aSize aPosition |
	
	aSize := end.
	
	position <= (aSize + 1)
		ifFalse: [ self error: 'Index out of bounds: ', position asString ].
	
	aPosition := position min: aSize.
	
	anItem := rope collection at: aPosition.
	position := aPosition - 1.
	
	^ anItem
]

{ #category : #'instance creation' }
BlCollectionRopeIterator >> rope: aRope from: aStart to: anEnd [
	super rope: aRope from: aStart to: anEnd.
	position := aStart
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ #()
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> skip: aNumber [
	position := ((position + aNumber) max: 0) min: end + 1
]
