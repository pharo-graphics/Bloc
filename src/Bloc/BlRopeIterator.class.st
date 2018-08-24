"
I define an API of a rope iterator.

It is highly recommended to use iterator to enumerate ropes, since it can be done in constant time.
I support forward and reverse directions of enumeration
"
Class {
	#name : #BlRopeIterator,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'rope',
		'start',
		'end'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #'instance creation' }
BlRopeIterator class >> rope: aRope from: aStart to: anEnd [
	^ self new
		rope: aRope from: aStart to: anEnd;
		yourself
]

{ #category : #'iterator - accessing' }
BlRopeIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #Objects>
	
	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlRopeIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BrTextAttribute or: #Object>

	^ self attributes
		detect: aBlock
		ifFound: aFoundBlock
		ifNone: anExceptionBlock
]

{ #category : #'iterator - testing' }
BlRopeIterator >> hasNext [
	"Return true if there is a next element, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlRopeIterator >> hasPrevious [
	"Return true if there is a previous element, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlRopeIterator >> isCarriageReturn: anItem [
	"Return true of given item represents a carriage return, false otherwise"
	<return: #Boolean>

	^ anItem = Character cr
]

{ #category : #'iterator - testing' }
BlRopeIterator >> isLineDelimiter: anItem [
	"Return true of given item represents a line delimiter symbol, false otherwise"
	<return: #Boolean>

	^ (self isCarriageReturn: anItem) or: [ self isLineFeed: anItem ]
]

{ #category : #'iterator - testing' }
BlRopeIterator >> isLineFeed: anItem [
	"Return true of given item represents a line feed, false otherwise"
	<return: #Boolean>

	^ anItem = Character lf
]

{ #category : #'iterator - testing' }
BlRopeIterator >> isNewLine: anItem [
	"Return true of given item represents a carriage return, false otherwise"
	<return: #Boolean>

	^ anItem = Character cr or: [ anItem = Character lf ]
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> next [
	"Return next element in the rope"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlRopeIterator >> nextLine [
	| aSegment |
	
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].

	aSegment := (self isNewLine: self peek) 
		ifTrue: [ self next. BlCollectionRope collection: '' ]
		ifFalse: [ self nextSegment: [ :anItem | self isNewLine: anItem ] ].

	(self hasNext and: [ (self isNewLine: self peek) and: [ self position + 1 <= end ]  ])
		ifTrue: [
			self next.
			(self hasNext and: [ (self isNewLine: self peek) ])
				ifTrue: [ self previous ] ].

	

	^ aSegment
]

{ #category : #accessing }
BlRopeIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line
		- end index of line without line delimiter
		- end index of line including line delimiter(s) CR, LF or CRLF"
	| aLineStart aLineEnd aLineEndWithDelimiters aFirstItem |

	self hasNext
		ifFalse: [ self error: 'Reached end of rope' ].

	aLineStart := self position.
	aLineEnd := aLineStart.
	aLineEndWithDelimiters := aLineStart.

	aFirstItem := self peek.

	(self isLineDelimiter: aFirstItem)
		ifTrue: [
			aLineStart := self position - 1.
			aLineEnd := aLineStart.
			aLineEndWithDelimiters := aLineEnd + 1.  ]
		ifFalse: [
			aLineStart := self position.
			self nextSegment: [ :anItem | self isLineDelimiter: anItem ].
			aLineEnd := (self position - 1) max: aLineStart.
			aLineEndWithDelimiters := aLineEnd ].

	self hasNext
		ifTrue: [
			aFirstItem := self peek.
			(self isLineDelimiter: aFirstItem)
				ifTrue: [ 
					self next.
					(self hasNext and: [ (self isCarriageReturn: aFirstItem) and: [ self isLineFeed: self peek ] ])
						ifTrue: [ self next ].
					aLineEndWithDelimiters := self position - 1 ] ].

	anIndicesBlock
		value: aLineStart
		value: aLineEnd
		value: aLineEndWithDelimiters
]

{ #category : #accessing }
BlRopeIterator >> nextSegment: aBlock [
	"Return a segment of item for those aBlock answers false"
	| fromIndex toIndex initialValue |
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	"store position right before iteration"
	fromIndex := self position.
	
	"we want to have homogenous segments, so check what is the initial value"
	initialValue := aBlock value: self peek.
	self next.

	"we skip all items that do not belong to segment"
	[ self hasNext and: [ (aBlock value: self peek) = initialValue ] ] whileTrue: [ self next ].
	
	toIndex := (fromIndex = self position)
		ifTrue: [ self hasNext ifTrue: [ self next ]. fromIndex ]
		ifFalse: [ self position - 1 ].

	^ self rope from: fromIndex to: toIndex
]

{ #category : #accessing }
BlRopeIterator >> nextSpan [
	"Return a next homogeneous subrope based on attributes"
	^ self subclassResponsibility
]

{ #category : #accessing }
BlRopeIterator >> nextWhitespace [

	^ self nextSegment: [ :item | item isCharacter not or: [ item isSeparator not ] ]
]

{ #category : #accessing }
BlRopeIterator >> nextWord [

	^ self nextSegment: [ :item | item isCharacter and: [ item isSeparator ] ]
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> peek [
	"Return an element at current #position without changing it.
	(#peek item is the same that was returned by #next or #previous)"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - accessing' }
BlRopeIterator >> position [
	"Return position of the peek element.
	#next element is at position + 1.
	#previous element is at position - 1"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> previous [
	"Return previous element in the rope"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlRopeIterator >> rope [
	^ rope
]

{ #category : #'instance creation' }
BlRopeIterator >> rope: aRope from: aStart to: anEnd [
	(aRope isNotEmpty and: [ aStart < 0 or: [ anEnd > aRope size ] ])
		ifTrue: [ self error: 'Iterator interval out of bounds!' ].
	(aRope isEmpty and: [ aStart ~= 0 or: [ anEnd ~= 0 ] ])
		ifTrue: [ self error: 'Iterator interval out of bounds!' ].

	rope := aRope.
	start := aStart min: anEnd.
	end := anEnd max: aStart.
]

{ #category : #'iterator - testing' }
BlRopeIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BrTextAttribute>

	^ self attributes select: aBlock
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> skip: aNumber [
	"Skip given amount of items (that would be returned by #next or #prevous).
	aNumber can be negative and positive, sign defines a direction of iteration"

	self subclassResponsibility
]
