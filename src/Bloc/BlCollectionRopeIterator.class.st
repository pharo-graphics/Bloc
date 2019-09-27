"
I am a special iterator used to iterate over collection rope
"
Class {
	#name : #BlCollectionRopeIterator,
	#superclass : #BlRopeIterator,
	#instVars : [
		'position'
	],
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #'private - asserting' }
BlCollectionRopeIterator >> assertInvariant [
	"I am a position invariant; I make sure that iterator operations do not go out of bounds"

	(position >= start)
		ifFalse: [ self error: 'Position must always be greater or equal than start' ].

	(position <= end)
		ifFalse: [ self error: 'Position must always be less or equal than end' ].
]

{ #category : #'iterator - attributes' }
BlCollectionRopeIterator >> attributes [
	^ #()
]

{ #category : #'iterator - testing' }
BlCollectionRopeIterator >> hasNext [
	<return: #Boolean>
	self assertInvariant.

	^ position < end
]

{ #category : #'iterator - testing' }
BlCollectionRopeIterator >> hasPrevious [
	<return: #Boolean>
	self assertInvariant.

	^ position > start
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> next [
	<return: #Object>
	
	self hasNext
		ifFalse: [ self errorReachedTheEnd ].
	
	^ rope at: (position := position + 1)
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> nextSpan [
	<return: #BlRope>
	| aSpan |

	self hasNext
		ifFalse: [ self errorReachedTheEnd ].

	aSpan := rope from: position to: end.
	position := end.

	^ aSpan
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> peek [
	<return: #Object>

	self hasNext
		ifFalse: [ self errorReachedTheEnd ].

	^ rope at: position + 1
]

{ #category : #'as yet unclassified' }
BlCollectionRopeIterator >> peer [
	<return: #Object>

	self hasPrevious
		ifFalse: [ self errorReachedTheStart ].

	^ rope at: position
]

{ #category : #'iterator - accessing' }
BlCollectionRopeIterator >> position [
	<return: #Number>

	^ position
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> previous [
	<return: #Object>
	| anItem |

	self hasPrevious
		ifFalse: [ self errorReachedTheStart ].
	
	anItem := rope at: position.
	position := position - 1.

	^ anItem
]

{ #category : #'instance creation' }
BlCollectionRopeIterator >> rope: aRope from: aStart to: anEnd [
	super rope: aRope from: aStart to: anEnd.

	position := aStart.
	self assertInvariant
]

{ #category : #'iterator - enumeration' }
BlCollectionRopeIterator >> skip: aNumber [
	| newPosition |
	
	newPosition := position + aNumber.
	
	newPosition <= end
		ifFalse: [ self errorOvershootsTheEnd ].
		
	newPosition >= start
		ifFalse: [ self errorOvershootsTheStart ].

	position := newPosition
]
