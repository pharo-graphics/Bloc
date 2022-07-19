Class {
	#name : #BlTextParagraphLeaf,
	#superclass : #BlTextParagraphSegment,
	#instVars : [
		'span',
		'measurer'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'accessing - span' }
BlTextParagraphLeaf >> attributes [
	"Return a set of attributes applied on this span"
	<return: #Set of: #BlTextAttribute>

	^ span attributes
]

{ #category : #accessing }
BlTextParagraphLeaf >> indexAtPosition: aPoint [

	"I return a cursor index at a given position as a Point provided in local coordinates of this span"

	| aWidth |
	aWidth := aPoint x max: 0.

	aWidth <= 0 ifTrue: [ ^ self from - 1 max: 0 ].
	aWidth >= self advance ifTrue: [ ^ self to ].

	^ (self spanStart to: self spanEnd)
		  findBinary: [ :anIndex | "exact match"
			  | aSubSpan aParagraph |
			  aSubSpan := BlSpan
				              text: (span text from: (1 min: anIndex) to: anIndex)
				              attributes: self attributes.

			  aParagraph := self measurer measureTextSpan: aSubSpan.

			  (aWidth closeTo: aParagraph advance epsilon: 0.1)
				  ifTrue: [ 0 ]
				  ifFalse: [ (aWidth - aParagraph advance) sign ] ]
		  do: [ :anIndex | "need to measure a bit more" 
		  self from + anIndex - 1 ]
		  ifNone: [ :a :b | 
			  | leftIndex rightIndex leftWidth leftSpanIndex rightWidth rightSpanIndex spanIndex |
			  leftIndex := a ifNil: [ self spanStart - 1 ].
			  rightIndex := b ifNil: [ self spanEnd + 1 ].

			  leftIndex < self spanStart
				  ifTrue: [ 
					  leftWidth := 0.
					  leftSpanIndex := self spanStart - 1 max: 0 ]
				  ifFalse: [ 
					  | aSubSpan aParagraph |
					  aSubSpan := BlSpan
						              text:
						              (span text from: (1 min: leftIndex) to: leftIndex)
						              attributes: self attributes.
					  aParagraph := self measurer measureTextSpan: aSubSpan.
					  leftWidth := aParagraph advance.
					  leftSpanIndex := leftIndex ].

			  rightIndex > self spanEnd
				  ifTrue: [ 
					  rightWidth := self advance.
					  rightSpanIndex := self spanEnd ]
				  ifFalse: [ 
					  | aSubSpan aParagraph |
					  aSubSpan := BlSpan
						              text:
						              (span text
							               from: (1 min: rightIndex)
							               to: rightIndex)
						              attributes: self attributes.
					  aParagraph := self measurer measureTextSpan: aSubSpan.
					  rightWidth := aParagraph advance.
					  rightSpanIndex := rightIndex ].

			  spanIndex := aWidth
			               <= (leftWidth + (rightWidth - leftWidth / 2.0))
				               ifTrue: [ leftSpanIndex ]
				               ifFalse: [ rightSpanIndex ].

			  self from + spanIndex - 1 ]
]

{ #category : #accessing }
BlTextParagraphLeaf >> measurer [

	^ measurer
]

{ #category : #initialization }
BlTextParagraphLeaf >> measurer: aSpanMeasurer [

	measurer := aSpanMeasurer
]

{ #category : #measurement }
BlTextParagraphLeaf >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'Do we need this ?'.
	self subclassResponsibility
]

{ #category : #geometry }
BlTextParagraphLeaf >> positionAt: anIndex [

	| aSpanIndex aSubSpan aMeasuredSpan aPositionY aPositionX |
	aPositionY := self baseline y.
	aPositionX := self baseline x.

	anIndex = (self from - 1) ifTrue: [ ^ aPositionX @ aPositionY ].
	anIndex = self to ifTrue: [ ^ aPositionX + self advance @ aPositionY ].

	aSpanIndex := anIndex - self from + 1.

	aSubSpan := BlSpan
		            text:
		            (span text from: (1 min: aSpanIndex) to: aSpanIndex)
		            attributes: self span attributes.

	aMeasuredSpan := self measurer measureTextSpan: aSubSpan.

	^ aPositionX + aMeasuredSpan advance @ aPositionY
]

{ #category : #printing }
BlTextParagraphLeaf >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: span;
		nextPut: $)

]

{ #category : #accessing }
BlTextParagraphLeaf >> span [

	^ span
]

{ #category : #accessing }
BlTextParagraphLeaf >> span: aBlSpan [
	span := aBlSpan
]

{ #category : #'accessing - span' }
BlTextParagraphLeaf >> spanEnd [

	^ span size
]

{ #category : #'accessing - span' }
BlTextParagraphLeaf >> spanLength [

	^ (self spanStart isZero and: [ self spanEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ self spanEnd - self spanStart + 1 ]
]

{ #category : #'accessing - span' }
BlTextParagraphLeaf >> spanStart [

	^ 1 min: span size
]

{ #category : #accessing }
BlTextParagraphLeaf >> text: aGlobalText from: aGlobalTextStart to: aGlobalTextEnd [
	"Assign the paragraph's text with provided indices so that we could always determine which part of it I measure"

	paragraph := aGlobalText.
	from := aGlobalTextStart.
	to := aGlobalTextEnd
]
