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
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #'private - asserting' }
BlConcatenationRopeIterator >> assertInvariant [

	"I am a position invariant; I make sure that iterator operations do not go out of bounds"

	(position >= start)
		ifFalse: [ self error: 'Position must always be greater or equal than start' ].

	(position <= end)
		ifFalse: [ self error: 'Position must always be less or equal than end' ]
]

{ #category : #'iterator - attributes' }
BlConcatenationRopeIterator >> attributes [
	<return: #Collection of: #Objects>
	
	^ currentIterator attributes
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> backwardIteratorAt: aPosition [
	<return: #BlRopeIterator>

	^ self
		subIteratorAt: aPosition
		isForward: false
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> currentIterator [
	<return: #BlRopeIterator>
	
	^ currentIterator
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> forwardIteratorAt: aPosition [
	<return: #BlRopeIterator>

	^ self
		subIteratorAt: aPosition
		isForward: true
]

{ #category : #'iterator - testing' }
BlConcatenationRopeIterator >> hasNext [
	<return: #Boolean>
	self assertInvariant.

	^ position < end
]

{ #category : #'iterator - testing' }
BlConcatenationRopeIterator >> hasPrevious [
	<return: #Boolean>
	self assertInvariant.

	^ position > start
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> moveBackward [
	self moveBackward: 1
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> moveBackward: aNumber [
	"!!! I do not alter the position of the sub-iterator, it must be done right before calling me"

	self
		assert: [ aNumber >= 0 ]
		description: [ 'The amount of steps must not be negative' ].

	position := position - aNumber.

	self
		assert: [ position >= start ]
		description: [ 'Position must not exceed bounds' ].

	currentIterator hasPrevious
		ifFalse: [ currentIterator := self backwardIteratorAt: position ]
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> moveForward [
	self moveForward: 1
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> moveForward: aNumber [
	"!!! I do not alter the position of the sub-iterator, it must be done right before calling me"

	self
		assert: [ aNumber >= 0 ]
		description: [ 'The amount of steps must not be negative' ].

	position := position + aNumber.

	self
		assert: [ position <= end ]
		description: [ 'Position must not exceed bounds' ].

	(self hasNext and: [ currentIterator hasNext not ])
		ifTrue: [ currentIterator := self forwardIteratorAt: position ]
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> next [
	<return: #Object>
	| anItem |
	
	self hasNext
		ifFalse: [ self errorReachedTheEnd ].

	currentIterator hasNext
		ifFalse: [ currentIterator := self forwardIteratorAt: position ].

	anItem := currentIterator next.
	self moveForward.

	^ anItem
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> nextSpan [
	<return: #BlRope>
	| theAttributes aStart anEnd |
	
	self hasNext
		ifFalse: [ self errorReachedTheEnd ].

	aStart := self position.
	theAttributes := self attributes.

	[ self hasNext and: [ self attributes = theAttributes ] ] whileTrue: [ 
		| nextRun |
		nextRun := currentIterator nextSpan.
		self moveForward: nextRun size ].

	anEnd := self position.
	
	^ rope from: aStart to: anEnd
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> peek [
	<return: #Object>
	
	self hasNext
		ifFalse: [ self errorReachedTheEnd ].
	
	currentIterator hasNext
		ifFalse: [ currentIterator := self forwardIteratorAt: position ].

	^ currentIterator peek
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> peer [
	<return: #Object>
	
	self hasPrevious
		ifFalse: [ self errorReachedTheStart ].
	
	currentIterator hasPrevious
		ifFalse: [ currentIterator := self backwardIteratorAt: position ].

	^ currentIterator peer
]

{ #category : #'iterator - accessing' }
BlConcatenationRopeIterator >> position [
	<return: #Number>

	^ position
]

{ #category : #copying }
BlConcatenationRopeIterator >> postCopy [
	super postCopy.

	currentIterator := currentIterator copy
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> previous [
	<return: #Object>
	| anItem |
	
	self hasPrevious
		ifFalse: [ self errorReachedTheStart ].

	currentIterator hasPrevious
		ifFalse: [ currentIterator := self backwardIteratorAt: position ].

	anItem := currentIterator previous.
	self moveBackward.

	^ anItem
]

{ #category : #'instance creation' }
BlConcatenationRopeIterator >> rope: aRope from: aStart to: anEnd [
	super rope: aRope from: aStart to: anEnd.

	position := aStart.
	currentIterator := self forwardIteratorAt: aStart
]

{ #category : #'iterator - enumeration' }
BlConcatenationRopeIterator >> skip: aNumber [
	| newPosition |
	
	newPosition := position + aNumber.
	
	newPosition <= end
		ifFalse: [ self errorOvershootsTheEnd ].
		
	newPosition >= start
		ifFalse: [ self errorOvershootsTheStart ].

	aNumber abs <= 5
		ifTrue: [
			(aNumber >= 0)
				ifTrue: [ aNumber timesRepeat: [ self next ] ]
				ifFalse: [ aNumber negated timesRepeat: [ self previous ] ] ]
		ifFalse: [
			position := newPosition.
			currentIterator := (aNumber >= 0)
				ifTrue: [ self forwardIteratorAt: position ]
				ifFalse: [ self backwardIteratorAt: position ] ]
]

{ #category : #'private - enumeration' }
BlConcatenationRopeIterator >> subIteratorAt: aPosition isForward: isForward [
	<return: #BlRopeIterator>
	| aCurrentRope aCurrentPosition aCurrentEnd |

	aCurrentRope := rope.
	aCurrentPosition := aPosition.
	aCurrentEnd := end.
	
	[ aCurrentRope isConcatenation ] whileTrue: [ 
		| isLeft |
		isLeft := isForward
			ifTrue: [ aCurrentPosition < aCurrentRope left size ]
			ifFalse: [ aCurrentPosition <= aCurrentRope left size ].
		
		aCurrentRope := isLeft
			ifTrue: [
				aCurrentEnd := aCurrentEnd min: aCurrentRope left size.
				aCurrentRope left ]
			ifFalse: [
				aCurrentPosition := aCurrentPosition - aCurrentRope left size.
				aCurrentEnd := aCurrentEnd - aCurrentRope left size.
				aCurrentEnd := aCurrentEnd min: aCurrentRope right size.
				aCurrentRope right ].
		
		aCurrentRope isScoped
			ifTrue: [
				aCurrentPosition := aCurrentPosition + aCurrentRope offset.
				aCurrentEnd := (aCurrentEnd + aCurrentRope offset).
				aCurrentRope := aCurrentRope rope ] ].

	^ isForward
		ifTrue: [
			aCurrentRope
				iterator: aCurrentPosition
				to: aCurrentEnd"((aCurrentPosition + end - aPosition + 1) min: aCurrentRope size)" ]
		ifFalse: [
			aCurrentRope
				iterator: aCurrentPosition
				to: ((aCurrentPosition - (aPosition - start + 1)) max: 0) ]
]
