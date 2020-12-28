Class {
	#name : #BlSingleLineTextParagraph,
	#superclass : #BlTextParagraph,
	#instVars : [
		'line'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> advance [
	^ self line advance
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> ascent [
	<return: #Number>

	^ self line ascent
]

{ #category : #baselines }
BlSingleLineTextParagraph >> baselineChanged [
	self line baseline: self baseline
]

{ #category : #'paragraph - measuring' }
BlSingleLineTextParagraph >> basicMeasureOn: aSpanMeasurer [
	"Measure and create lines with text spans from provided text based on attributes and layout properties (maximum width / height)"
	| anIterator aMeasurer |

	aMeasurer := self createMeasurer.
	aMeasurer line paragraph: self.

	(self text isEmpty) ifTrue: [ 
		aMeasurer
			measureSpan: (BlSpan text: self text empty attributes: #())
			of: self
			with: aSpanMeasurer ].

	anIterator := text iterator.
	[ anIterator hasNext and: [ line isEmpty or: [ aMeasurer hasAvailableSpace ] ] ] whileTrue: [ 
		"If we pass #hasNext check we will definitely move to the next span,
		so can do the same with position"
		aMeasurer movePosition: anIterator position + 1.
		aMeasurer
			measureSpan: anIterator nextSpan
			of: self
			with: aSpanMeasurer ].

	"measurer creates a line with baseline set to 0@0"
	line := aMeasurer line.
	end := line to
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> bounds [
	^ self line bounds
]

{ #category : #initialization }
BlSingleLineTextParagraph >> defaultMeasurer [
	^ BlSingleLineTextParagraphMeasurer new
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> descent [
	<return: #Number>

	^ self line descent
]

{ #category : #finalization }
BlSingleLineTextParagraph >> finalize [

	line ifNotNil: #finalize.
	line := nil
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> height [
	^ self line height
]

{ #category : #testing }
BlSingleLineTextParagraph >> isEmpty [
	^ self line isEmpty
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> left [
	^ self line left
]

{ #category : #accessing }
BlSingleLineTextParagraph >> line [
	"Return a line behind this paragraph"
	<return: #BlTextParagraphLine>

	^ line
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> looseBounds [
	^ 0 @ 0 extent: self line advance @ (self ascent abs + self descent)
]

{ #category : #'paragraph - measuring' }
BlSingleLineTextParagraph >> normalize: aScale [
	self line normalize: aScale
]

{ #category : #initialization }
BlSingleLineTextParagraph >> reset [
	super reset.
	
	line := BlTextParagraphLine new.
	line baseline: self baseline.
	line paragraph: self
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> spanAtIndex: anIndex [
	<return: #BlTextParagraphSpan>

	self
		assert: [ self line isEmpty not ]
		description: [ 'There must be at least one span!' ].
		
	self
		assert: [ self text isNotEmpty or: [ anIndex isZero ] ]
		description: [ 'If text is empty index must be zero' ].
		
	self
		assert: [ self text isEmpty or: [ anIndex between: 0 and: self text size ] ]
		description: [ 'anIndex must be within text bounds (0 is allowed)' ].
	
	anIndex isZero
		ifTrue: [ ^ self line spans first ].
		
	anIndex = self text size
		ifTrue: [ ^ self line spans last ].

	^ self line spans
		findBinary: [ :aParagraphSpan |
			(anIndex between: aParagraphSpan from and: aParagraphSpan to )
				ifTrue: [ 0 ]
				ifFalse: [ | spanCenter |
					spanCenter := aParagraphSpan from + ((aParagraphSpan to - aParagraphSpan from) // 2).
					anIndex < spanCenter
						ifTrue: [ -1 ]
						ifFalse: [ 1 ] ] ]
		ifNone: [ self error: 'Span for character at index ', anIndex asString, ' does not exist' ]
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> spanAtPoint: aPoint ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Find a paragraph span that contains a given point given in a paragraph coordinates
	and evaluate a found block if such span was found or evaluate an exception block
	with the closest span to a point"
	<return: #BlTextParagraphSpan>

	^ self line spans
		findBinary: [ :aParagraphSpan |
			| originX cornerX |
			originX := aParagraphSpan baseline x.
			cornerX := originX + aParagraphSpan advance.
			(aPoint x between: originX and: cornerX )
				ifTrue: [ 0 ]
				ifFalse: [ | spanCenter |
					spanCenter := originX + ((cornerX - originX) / 2.0).
					aPoint x < spanCenter
						ifTrue: [ -1 ]
						ifFalse: [ 1 ] ] ]
		do: [ :aParagraphSpan | aFoundBlock cull: aParagraphSpan ]
		ifNone: [ :a :b | anExceptionBlock cull: (a ifNil: [ b ] ifNotNil: [ a ]) ]
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> tightBounds [
	^ self line bounds translateBy: self baseline
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> top [
	^ self line top
]

{ #category : #'paragraph - geometry' }
BlSingleLineTextParagraph >> width [
	^ self line width
]
