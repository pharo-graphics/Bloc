"
I define a data structure independent text iterator api.

Use me for text enumeration purposes

"
Class {
	#name : #BlTextIterator,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Text-Text'
}

{ #category : #'iterator - accessing' }
BlTextIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #BlTextAttribute>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlTextIterator >> doesAttributeEnd: anAttribute [
	"Return true if a given attribute ends at the current position.
	By `ends` we mean that this attribute is not present at the next position.
	
	Implementation detail:
	 - we should not rely on the iterator scope, otherwise it will give us false positives on the edge of the scope for attributes that don't really end there."
	<return: #Boolean>
	
	"we are at the last character, so the attribute definitely ends here"
	self text size = self position
		ifTrue: [ ^ true ].
	
	(self attributes includes: anAttribute)
		ifFalse: [ ^ true ].
	
	"check if this attribute exists at the next position, if not - it ends here"
	^ ((self text attributesAt: self position + 1) includes: anAttribute) not
]

{ #category : #'iterator - testing' }
BlTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"

	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlTextIterator >> hasPrevious [
	"Return true if there is a previous text item (character) before the current position"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> next [
	"Return an item (character) at current position and move one to the right"

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextAttributeStartAndEnd: aBlTextAttribute indicesDo: anIndicesBlock [
	"Find and iterate over the start and end indices of the given attribute"	
	
	^ self
		nextAttributeStartAndEndSuchThat: [ :eachAttribute | eachAttribute == aBlTextAttribute ]
		indicesDo: anIndicesBlock
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextAttributeStartAndEndSuchThat: aComparisonBlock indicesDo: anIndicesBlock [
	"Find and iterate over the start and end indices of the given attribute"	
	| startPosition endPosition isAttributeStartFound isAttributeEndFound |

	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	startPosition := nil.
	endPosition := nil.
	
	isAttributeStartFound := false.
	isAttributeEndFound := false.

	[ self hasNext and: [
		| hasAttribute aSpan aCurrentPosition |

		aCurrentPosition := self position + 1.

		aSpan := self nextSpan.
		hasAttribute := aSpan attributes anySatisfy: [ :eachAttribute | aComparisonBlock value: eachAttribute ] .
		
		"we found the start of the attribute"
		(hasAttribute and: [ isAttributeStartFound not ])
			ifTrue: [
				startPosition := aCurrentPosition.
				isAttributeStartFound := true ].
	
		"we found the end of the attribute"
		(hasAttribute not and: [ isAttributeStartFound ])
			ifTrue: [
				endPosition := aCurrentPosition - 1.
				isAttributeEndFound := true ].
		
		(isAttributeStartFound and: [ isAttributeEndFound ]) not
	] ] whileTrue.

	(isAttributeStartFound and: [ isAttributeEndFound not ])
		ifTrue: [
			endPosition := self position.
			isAttributeEndFound := true ].
	
	^ (isAttributeStartFound and: [ isAttributeEndFound ])
		ifTrue: [ 
			anIndicesBlock
				value: startPosition
				value: endPosition ]
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextAttributedEnd: aBlock indicesDo: anIndicesBlock [
	"Find and iterate over the last indices of the attributes for which aBlock returns true"	
	| startPosition endPosition theEndedAttributes |

	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	startPosition := self position + 1.
	endPosition := startPosition.
	theEndedAttributes := OrderedCollection new.

	[ self hasNext and: [
		| theAttributes |
		
		theAttributes := self attributes select: aBlock.
		theEndedAttributes := theAttributes
			select: [ :eachAttribute | self doesAttributeEnd: eachAttribute ].
		theEndedAttributes isNotEmpty
			ifTrue: [ self next ].
		
		theEndedAttributes ifEmpty: [
			| nextSpan |
			
			nextSpan := self nextSpan.
			theAttributes := nextSpan attributes select: aBlock.
			theEndedAttributes := theAttributes
				select: [ :eachAttribute | self doesAttributeEnd: eachAttribute ] ].
		endPosition := self position.
		"there are no ended attributes, continue"
		theEndedAttributes isEmpty
	] ] whileTrue.

	self
		assert: [ startPosition <= endPosition ]
		description: [ 'Start must not exceed end' ].
		
	self
		assert: [ startPosition > 0 or: [ startPosition = 0 and: [ endPosition = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	
	^ anIndicesBlock
		value: startPosition
		value: endPosition
		value: theEndedAttributes
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextLine [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line
		- end index of line without line delimiter
		- end index of line including line delimiter(s)"
		
	self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextLineIndicesDo: anIndicesBlock shouldMerge: aMergeBlock [
	"Iterate over lines within current text and
		execute aSplitBlock with the 3 arguments for each potential line:
			- start index of line
			- end index of line without line delimiter
			- end index of line including line delimiter(s).
	
	If aMergeBlock returns false, then procide with
		execute anIndicesBlock with 3 arguments for each line:
			- start index of line
			- end index of line without line delimiter
			- end index of line including line delimiter(s).
	
	else if aMergeBlock returns true ignore a line delimiter and `merge` lines"
	| shouldMerge actualStart actualEnd actualDelimiterIndex |

	shouldMerge := true.
	actualStart := nil.
	
	[ shouldMerge ] whileTrue: [
		self nextLineIndicesDo: [ :aStart :anEnd :aDelimiterEnd |
			shouldMerge := aDelimiterEnd > anEnd and: [
				aMergeBlock
					value: aStart
					value: anEnd
					value: aDelimiterEnd ].
			
			actualStart
				ifNil: [ actualStart := aStart ].
			
			actualEnd := anEnd.
			actualDelimiterIndex := aDelimiterEnd.
			
			self hasNext ifFalse: [ shouldMerge := false ] ] ].
	
	self
		assert: [ actualStart <= (actualEnd + 1) ]
		description: [ 'Start must not exceed end' ].
		
	self
		assert: [ actualStart > 0 or: [ actualStart = 0 and: [ actualEnd = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	
	anIndicesBlock
		value: actualStart
		value: actualEnd
		value: actualDelimiterIndex
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSegment: aBlock [
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSegment: aBlock indicesDo: anIndicesBlock [
	"Evaluate aBlock with every item in the forward direction until aBlock returns a different value compared to the value
	produced by evaluating aBlock with the first item in a sequence or until we run out of items to iterate over.

	Once completed evaluate anIndicesBlock with the start and end position of the iterator thus defining a homogenous segment
	for every item of which aBlock returns the same value. The third argument of the anIndicesBlock is (optional) initial value which was used for comparison.
	
	 H E L L O
	^ ^ ^ ^ ^ ^
	0 1 2 3 4 5
	
	Please note, that the result of evaluation of aBlock should not necessarily be a boolean, it can be any object.

	I return the result of evaluation of anIndicesBlock"
	<return: #Object>
	
	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSpan [
	"Return a next homogeneous text span"
	<return: #BlSpan>
	
	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSpan: aBlock [
	"Return a text whose attributes of each characters evaluate aBlock to the same value,
	e.g. either false or true"
	<return: #BlSubText>

	^ self
		nextSpanAny: aBlock
		indicesDo: [ :aStart :anEnd :hasValue | self text from: aStart to: anEnd	]
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSpan: aBlock indicesDo: anIndicesBlock [
	| theMatchedAttributes theMatchedAttributesSet startPosition endPosition |

	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].

	theMatchedAttributes := nil.
	theMatchedAttributesSet := nil.

	startPosition := self position + 1.
	endPosition := startPosition.

	[ self hasNext and: [
		| theNextAttributes theNextAttributesSet |
		theNextAttributes := (self attributes select: aBlock).
		theNextAttributesSet := theNextAttributes asSet.
	
		theMatchedAttributes ifNil: [
			theMatchedAttributes := theNextAttributes.
			theMatchedAttributesSet := theNextAttributesSet ].
	
		theMatchedAttributesSet = theNextAttributesSet.
	] ] whileTrue: [ self nextSpan ].

	endPosition := self position.
	
	self
		assert: [ startPosition <= endPosition ]
		description: [ 'Start must not exceed end' ].
		
	self
		assert: [ startPosition > 0 or: [ startPosition = 0 and: [ endPosition = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	
	^ anIndicesBlock
		value: startPosition
		value: endPosition
		value: theMatchedAttributes
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSpanAny: aBlock indicesDo: anIndicesBlock [
	| initialValue startPosition endPosition |

	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].

	initialValue := nil.
	startPosition := self position + 1.
	endPosition := startPosition.

	[ self hasNext and: [
		| theNextValue |
		theNextValue := self attributes anySatisfy: aBlock.
		initialValue ifNil: [ initialValue := theNextValue ].
		initialValue = theNextValue.
	] ] whileTrue: [ self nextSpan ].

	endPosition := self position.
	
	self
		assert: [ startPosition <= endPosition ]
		description: [ 'Start must not exceed end' ].
		
	self
		assert: [ startPosition > 0 or: [ startPosition = 0 and: [ endPosition = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	
	^ anIndicesBlock
		value: startPosition
		value: endPosition
		value: initialValue
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextWhitespace [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextWord [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first space character"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> peek [
	"Return an item (character) at current position"
	<return: #Character or: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> peer [
	"Return an item (character) before current position"
	<return: #Character or: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - accessing' }
BlTextIterator >> position [
	"Return current iterator position within a text"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> previous [
	"Return an item (character) at current position and move one to the left"
	<return: #Character or: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> previousSegment: aBlock indicesDo: anIndicesBlock [
	"Evaluate aBlock with every item in the backward direction until aBlock returns a different value compared to the value
	produced by evaluating aBlock with the first item in a sequence or until we run out of items to iterate over.

	Once completed evaluate anIndicesBlock with the start and end position of the iterator thus defining a homogenous segment
	for every item of which aBlock returns the same value. The third argument of the anIndicesBlock is (optional) initial value which was used for comparison.
	
	 H E L L O
	^ ^ ^ ^ ^ ^
	0 1 2 3 4 5
	
	Please note, that the result of evaluation of aBlock should not necessarily be a boolean, it can be any object.

	I return the result of evaluation of anIndicesBlock"
	<return: #Object>
	
	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> skip: aNumber [
	"Move forward by aNumber characters"

	self subclassResponsibility
]

{ #category : #accessing }
BlTextIterator >> text [
	"Return an original text that I iterate over"
	<return: #BlText>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextIterator >> text: arg1 from: arg2 to: arg3 [
	^ self subclassResponsibility
]
