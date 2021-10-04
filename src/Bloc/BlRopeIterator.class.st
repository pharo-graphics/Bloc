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
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #'instance creation' }
BlRopeIterator class >> rope: aRope from: aStart to: anEnd [
	^ self new
		rope: aRope from: aStart to: anEnd;
		yourself
]

{ #category : #'iterator - attributes' }
BlRopeIterator >> attributes [
	"Return a collection of rope attributes at the current *peek* position without duplicates"
	<return: #Collection of: #Objects>

	^ self subclassResponsibility
]

{ #category : #'iterator - attributes' }
BlRopeIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ self attributes
		detect: aBlock
		ifFound: aFoundBlock
		ifNone: anExceptionBlock
]

{ #category : #'private - accessing' }
BlRopeIterator >> end [
	<return: #Number>
	
	^ end
]

{ #category : #'private - errors' }
BlRopeIterator >> errorOvershootsTheEnd [
	self error: 'Overshoots the end of the iterator!'
]

{ #category : #'private - errors' }
BlRopeIterator >> errorOvershootsTheStart [
	self error: 'Reached the end of the rope iterator!'
]

{ #category : #'private - errors' }
BlRopeIterator >> errorReachedTheEnd [
	self error: 'Reached the end of the rope iterator!'
]

{ #category : #'private - errors' }
BlRopeIterator >> errorReachedTheStart [
	self error: 'Overshoots the start of the iterator!'
]

{ #category : #'iterator - testing' }
BlRopeIterator >> hasNext [
	"Return true if iterator is be able to return #next item in the rope, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlRopeIterator >> hasPrevious [
	"Return true if iterator is be able to return #previous item in the rope, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> next [
	"Return next element in the rope"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextLine [
	"Return a next line without delimiters"
	<return: #BlRope>
	
	^ self nextLineIndicesDo: [ :aStart :anEnd :aLineEndWithDelimiters | self rope from: aStart to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line in cursor coordinates
		- end index of line without line delimiter in cursor coordinates
		- end index of line including line delimiter(s) in cursor coordinates"
	| aLineStart aLineEnd aDelimitedLineEnd |

	self hasNext
		ifFalse: [ self errorReachedTheEnd ].

	aLineStart := aLineEnd := aDelimitedLineEnd := self position.

	self
		nextSegment: [ :aBuffer |
			aBuffer first = Character lf
				ifTrue: [ 1 ]
				ifFalse: [
					(aBuffer first = Character cr and: [ aBuffer second ~= Character lf ])
						ifTrue: [ 1 ]
						ifFalse: [
							(aBuffer first = Character cr and: [ aBuffer second = Character lf ])
								ifTrue: [ 2 ]
								ifFalse: [ 0 ] ] ] ]
		indicesDo: [ :aStart :anEnd :anInitialMatchedLength :aFinalMatchedLength |
			aLineEnd := anInitialMatchedLength > 0
				ifTrue: [ aStart ]
				ifFalse: [ anEnd. ].
			aDelimitedLineEnd := anInitialMatchedLength > 0
				ifTrue: [ aLineEnd + anInitialMatchedLength ]
				ifFalse: [ aLineEnd + aFinalMatchedLength ].

			((aDelimitedLineEnd - anEnd) max: 0)
				timesRepeat: [
					self hasNext
						ifTrue: [ self next ] ] ]
		lookahead: 2
		breakWhen: [ :matchedBufferlength | matchedBufferlength > 0 ].

	^ anIndicesBlock
		value: aLineStart
		value: aLineEnd
		value: aDelimitedLineEnd
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextSegment: aBlock [
	"Return a segment of item for those aBlock uniformly returns equal value for each consequent item"
	<return: #BlRope>

	^ self
		nextSegment: aBlock
		indicesDo: [ :aStart :anEnd :anInitialValue | self rope from: aStart to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextSegment: aBlock indicesDo: anIndicesBlock [
	"Evaluate aBlock with every item in the forward direction until aBlock returns a different value compared to the value
	produced by evaluating aBlock with the first item in a sequence or until we run out of items to iterate over.

	Once completed evaluate anIndicesBlock with the start and end position of the iterator thus defining a homogenous segment
	for every item of which aBlock returns the same value. The third argument of the anIndicesBlock is (optional) initial value which was used for comparison.
	Please note, that the result of evaluation of aBlock should not necessarily be a boolean, it can be any object.

	I return the result of evaluation of anIndicesBlock"
	| fromIndex toIndex initialValue |
	<return: #Object>

	self hasNext
		ifFalse: [ self errorReachedTheEnd ].
	
	"store position right before iteration"
	fromIndex := self position.
	
	"we want to have homogenous segments, so check what is the initial value"
	initialValue := aBlock value: self next.

	"we skip all items that do not belong to segment"
	[ self hasNext and: [ (aBlock value: self peek) = initialValue ] ] whileTrue: [ self next ].
	
	toIndex := self position.

	^ anIndicesBlock
		cull: fromIndex
		cull: toIndex
		cull: initialValue
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextSegment: aBlock indicesDo: anIndicesBlock lookahead: aLookaheadAmount [
	"Evaluate aBlock with every item in the forward direction until aBlock returns a different value compared to the value
	produced by evaluating aBlock with the first item in a sequence or until we run out of items to iterate over.

	Once completed evaluate anIndicesBlock with the start and end position of the iterator thus defining a homogenous segment
	for every item of which aBlock returns the same value. The third argument of the anIndicesBlock is (optional) initial value which was used for comparison.
	Please note, that the result of evaluation of aBlock should not necessarily be a boolean, it can be any object.

	I return the result of evaluation of anIndicesBlock"
	^ self
		nextSegment: aBlock
		indicesDo: anIndicesBlock
		lookahead: aLookaheadAmount
		breakWhen: [ :aSegmentValue | false ]
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextSegment: aBlock indicesDo: anIndicesBlock lookahead: aLookaheadAmount breakWhen: aBreakBlock [
	"Evaluate aBlock with every item in the forward direction until aBlock returns a different value compared to the value
	produced by evaluating aBlock with the first item in a sequence or until we run out of items to iterate over.

	Once completed evaluate anIndicesBlock with the start and end position of the iterator thus defining a homogenous segment
	for every item of which aBlock returns the same value. The third argument of the anIndicesBlock is (optional) initial value which was used for comparison.
	Please note, that the result of evaluation of aBlock should not necessarily be a boolean, it can be any object.

	I return the result of evaluation of anIndicesBlock"
	| fromIndex toIndex lookaheadBuffer lookaheadIterator initialValue currentValue shouldBreak |
	<return: #Object>

	self hasNext
		ifFalse: [ self errorReachedTheEnd ].
	
	"store position right before iteration"
	fromIndex := self position.

	"allocate a look ahead buffer that will be used to preload N items before passing to the comparison block"
	lookaheadBuffer := LinkedList new.
	lookaheadIterator := self copy.

	aLookaheadAmount timesRepeat: [
		lookaheadIterator hasNext
			ifTrue: [ lookaheadBuffer addLast: lookaheadIterator next ]
			ifFalse: [ lookaheadBuffer addLast: nil ] ].
	
	self next.
	"we want to have homogenous segments, so check what is the initial value"
	initialValue := aBlock value: lookaheadBuffer.
	currentValue := initialValue.
	shouldBreak := aBreakBlock value: currentValue.

	"we skip all items that do not belong to segment"
	[ shouldBreak not and: [ self hasNext and: [
		lookaheadBuffer removeFirst.
			lookaheadIterator hasNext
				ifTrue: [ lookaheadBuffer addLast: lookaheadIterator peek ]
				ifFalse: [ lookaheadBuffer addLast: nil ].
		currentValue := aBlock value: lookaheadBuffer.	
		shouldBreak := aBreakBlock value: currentValue.
		currentValue = initialValue ] ] ]
			whileTrue: [
				self next .
				lookaheadIterator hasNext
					ifTrue: [ lookaheadIterator next ] ].

	toIndex := self position.

	^ anIndicesBlock
		cull: fromIndex
		cull: toIndex
		cull: initialValue
		cull: currentValue
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextSpan [
	"Return a next homogeneous subrope based on attributes"
	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextSpan: aBlock [
	"Evaluate aBlock with each attribute from each span and return a span for which aBlock returns either true or false.
	The key here is that we can redefine what homogeneity of the span mean"
	| initialValue aStart anEnd |
	<return: #BlRope>

	self hasNext
		ifFalse: [ self errorReachedTheEnd ].

	initialValue := nil.
	aStart := anEnd := self position.

	[ self hasNext and: [
		| theNextValue |
		theNextValue := self attributes anySatisfy: aBlock.
		initialValue ifNil: [ initialValue := theNextValue ].
		initialValue = theNextValue.
	] ] whileTrue: [ self nextSpan ].

	anEnd := self position.

	^ self rope from: aStart to: anEnd
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextWhitespace [
	<return: #BlRope>

	^ self nextSegment: [ :item | item isCharacter not or: [ item isSeparator not ] ]
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> nextWord [
	<return: #BlRope>

	^ self nextSegment: [ :item | item isCharacter and: [ item isSeparator not ] ]
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> peek [
	"Return an element at current #position without changing it.
	(#peek item is the same that would be returned by #next).
	I am similar to #peer but return an item to the right from the cursor"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> peer [
	"Return an element before the current #position without moving the cursor.
	(#peer item is the same that would be returned by #previous).
	I am similar to #peek but return an item to the left from the cursor.
	
	Q: Why peer?
	A: Due to this example: `a child peering from behind a tree`. By this logic when using #peer we look from behind (kind of before) the cursor"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - accessing' }
BlRopeIterator >> position [
	"Return a *cursor* position.
	
	 H E L L O
	^ ^ ^ ^ ^ ^
	0 1 2 3 4 5
	
	Imagine the cursor is at position 1.
		- If we #peek, we get 'E' and the `cursor` stays on its place.
		- If we ask for #next, the iterator returns 'E' and moves cursor one position to the right (2).
		- If we ask for #previous, we get 'H' and move one position to the left (0).
		- It is possible to #skip: positions either moving to the left or to the right"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #copying }
BlRopeIterator >> postCopy [
	
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> previous [
	"Return previous element in the rope"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> previousSegment: aBlock indicesDo: anIndicesBlock [
	"Evaluate aBlock with every item in the backward direction until aBlock returns a different value compared to the value
	produced by evaluating aBlock with the first item in a sequence or until we run out of items to iterate over.

	Once completed evaluate anIndicesBlock with the start and end position of the iterator thus defining a homogenous segment
	for every item of which aBlock returns the same value. The third argument of the anIndicesBlock is (optional) initial value which was used for comparison.
	Please note, that the result of evaluation of aBlock should not necessarily be a boolean, it can be any object.

	I return the result of evaluation of anIndicesBlock"
	| fromIndex toIndex initialValue |
	<return: #Object>

	self hasPrevious
		ifFalse: [ self errorReachedTheStart ].
	
	"store position right before iteration"
	toIndex := self position.
	
	"we want to have homogenous segments, so check what is the initial value"
	initialValue := aBlock value: self previous.

	"we skip all items that do not belong to segment"
	[ self hasPrevious and: [ (aBlock value: self peer) = initialValue ] ] whileTrue: [ self previous ].
	
	fromIndex := self position.

	^ anIndicesBlock
		cull: fromIndex
		cull: toIndex
		cull: initialValue
]

{ #category : #'private - accessing' }
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

{ #category : #'iterator - attributes' }
BlRopeIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ self attributes select: aBlock
]

{ #category : #'iterator - enumeration' }
BlRopeIterator >> skip: aNumber [
	"Skip given amount of items (that would be returned by #next or #prevous).
	aNumber can be negative and positive, sign defines a direction of iteration"

	self subclassResponsibility
]

{ #category : #'private - accessing' }
BlRopeIterator >> start [
	<return: #Number>
	
	^ start
]
