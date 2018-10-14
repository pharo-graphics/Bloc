"
I am a special iterator used to iterate over concatenation rope
"
Class {
	#name : #BlConcatenationRopeIterator,
	#superclass : #BlRopeIterator,
	#instVars : [
		'position',
		'currentIterator'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #asserting }
BlConcatenationRopeIterator >> assertInvariant [

	self
		assert: [ (start isZero and: [ end isZero and: [ position isZero ] ])
			or: [ start > 0 and: [ end > 0 and: [ start <= end and: [ position > 0 ] ] ] ] ]
		description: [ 'Start, end and position may only be zero at the same time,
			otherwise they all must be positive' ]
]

{ #category : #'iterator - accessing' }
BlConcatenationRopeIterator >> attributes [
	^ currentIterator attributes
]

{ #category : #private }
BlConcatenationRopeIterator >> backwardIteratorAt: aPosition [
	| aCurrentRope aCurrentPosition |

	aCurrentRope := rope.
	aCurrentPosition := aPosition.
	
	[ aCurrentRope isConcatenation ] whileTrue: [ 
		aCurrentRope := (aCurrentPosition <= aCurrentRope left size)
			ifTrue: [ aCurrentRope left ]
			ifFalse: [
				aCurrentPosition := aCurrentPosition - aCurrentRope left size.
				aCurrentRope right ] ].

	^ aCurrentRope
		iterator: aCurrentPosition
		to: ((aCurrentPosition - (aPosition - start + 1)) max: 1)
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ currentIterator
		detectAttribute: aBlock
		ifFound: aFoundBlock
		ifNone: anExceptionBlock
]

{ #category : #private }
BlConcatenationRopeIterator >> forwardIteratorAt: aPosition [
	| aCurrentRope aCurrentPosition |

	aCurrentRope := rope.
	aCurrentPosition := aPosition.

	[ aCurrentRope isConcatenation ] whileTrue: [ 
		aCurrentRope := (aCurrentPosition <= aCurrentRope left size)
			ifTrue: [ aCurrentRope left ]
			ifFalse: [
				aCurrentPosition := aCurrentPosition - aCurrentRope left size.
				aCurrentRope right ] ].

	^ aCurrentRope
		iterator: aCurrentPosition
		to: ((aCurrentPosition + end - aPosition + 1) min: aCurrentRope size)
]

{ #category : #'iterator - testing' }
BlConcatenationRopeIterator >> hasNext [
	"Return true if iterator is be able to return #next item in the rope, meaning that is
	didn't reached the end, false otherwise"
	<return: #Boolean>

	self assertInvariant.

	^ rope isNotEmpty
		and: [ (position <= rope size)
			and: [ position <= end
				and: [ position > 0 ] ] ]
]

{ #category : #'iterator - testing' }
BlConcatenationRopeIterator >> hasPrevious [
	^ (position >= 1) and: [ position >= start ]
]

{ #category : #private }
BlConcatenationRopeIterator >> moveBackward [

	position := (position - 1) min: end.
	
	currentIterator hasPrevious
		ifTrue: [ ^ self ].

	self hasPrevious ifFalse: [
		currentIterator := self forwardIteratorAt: position + 1.
		^ self ].
	
	currentIterator := self backwardIteratorAt: position
]

{ #category : #private }
BlConcatenationRopeIterator >> moveForward [

	self moveForward: 1
]

{ #category : #private }
BlConcatenationRopeIterator >> moveForward: aNumber [

	position := ((position max: 1) + aNumber) min: end + 1.

	self
		assert: [ position <= (end + 1) ]
		description: [ 'Position must not exceed bounds' ].

	currentIterator hasNext
		ifTrue: [ ^ self ].
	
	self hasNext ifFalse: [
		currentIterator := self backwardIteratorAt: position - 1.
		^ self ].
	
	currentIterator := self forwardIteratorAt: position
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> next [
	| next |
	next := currentIterator next.
	self moveForward.
	^ next
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> nextSpan [
	| theAttributes aStart anEnd |
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].

	aStart := position max: 1.
	theAttributes := self attributes.

	[ self hasNext and: [ self attributes = theAttributes ] ] whileTrue: [ 
		| nextRun |
		nextRun := currentIterator nextSpan.
		self moveForward: nextRun size ].
	
	anEnd := ((position - 1) max: 1) min: end.
	
	^ rope from: aStart to: anEnd
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> peek [
	^ currentIterator peek
]

{ #category : #'iterator - accessing' }
BlConcatenationRopeIterator >> position [
	^ position
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> previous [
	| previous |
	previous := currentIterator previous.
	self moveBackward.
	^ previous
]

{ #category : #'instance creation' }
BlConcatenationRopeIterator >> rope: aRope from: aStart to: anEnd [
	super rope: aRope from: aStart to: anEnd.

	position := aStart.
	currentIterator := self forwardIteratorAt: aStart
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ currentIterator selectAttributes: aBlock
]

{ #category : #accessing }
BlConcatenationRopeIterator >> skip: arg1 [ 
	^ self shouldBeImplemented
]
