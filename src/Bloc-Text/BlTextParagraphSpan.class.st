"
I represent a single measured span within ===BrTextParagraph===.
Depending on the type of a paragraph (single or multi line) I can be either a direct child of ===BrTextParagraph=== or be contained inside of ===BrTextParagraphLine===.

A span consists of 3 essential parts:

	- underlying text span with span start and end indices
	- generated glyph text run with start and end indices used for measurement and rendering
	- various measurement metrics computed during measurement step by ===BrTextParagraphSpanMeasurer===
"
Class {
	#name : #BlTextParagraphSpan,
	#superclass : #BlTextParagraphSegment,
	#instVars : [
		'textRun',
		'strikethroughOffset',
		'strikethroughSize',
		'span',
		'textRunStart',
		'textRunEnd',
		'spanStart',
		'spanEnd',
		'measurer',
		'isVertical'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BlTextParagraphSpan >> advance [
	<return: #Number>

	^ advance
]

{ #category : #initialization }
BlTextParagraphSpan >> applyFixedMetrics: aSpanMeasurer [

	width := aSpanMeasurer measuredWidth.
	height := aSpanMeasurer measuredHeight.
	
	ascent := aSpanMeasurer ascent.
	descent := aSpanMeasurer descent.

	strikethroughOffset := 0.
	strikethroughSize := 1.

	left := 0.
	top := 0.
	advance := width.
	
	baseline := 0@0
]

{ #category : #asserting }
BlTextParagraphSpan >> assertSpan [

	self
		assert: [ span isNotNil and: [ spanStart isNotNil and: [ spanEnd isNotNil ] ] ]
		description: [ 'Span is not initialized' ].
		
	self
		assert: [ span isNotEmpty or: [ spanStart isZero and: [ spanEnd isZero ] ] ]
		description: [ 'If span text is empty, start and end indices must be zero' ].
	
	self
		assert: [ span isEmpty or: [ spanStart between: 1 and: span size ] ]
		description: [ 'Span start must be within span bounds if it is not empty' ].
		
	self
		assert: [ span isEmpty or: [ spanEnd between: 1 and: span size ] ]
		description: [ 'Span end must be within span bounds if it is not empty' ].
		
	self
		assert: [ spanStart <= spanEnd ]
		description: [ 'Span start must be always smaller or equal to span end' ]
]

{ #category : #asserting }
BlTextParagraphSpan >> assertTextRun [

	self
		assert: [ textRun isNotNil and: [ textRunStart isNotNil and: [ textRunEnd isNotNil ] ] ]
		description: [ 'Text run is not initialized' ].
]

{ #category : #'accessing - span' }
BlTextParagraphSpan >> attributes [
	"Return a set of attributes applied on this span"
	<return: #Set of: #BlTextAttribute>
	
	self assertSpan.
	
	^ span attributes
]

{ #category : #finalization }
BlTextParagraphSpan >> finalize [

	textRun ifNotNil: [ :aTextRun | aTextRun release ].
	textRun := nil
]

{ #category : #geometry }
BlTextParagraphSpan >> indexAtPosition: aPoint [
	self deprecated: 'Use indexAtPosition:on:'
]

{ #category : #geometry }
BlTextParagraphSpan >> indexAtPosition: aPoint on: aCanvas [
	"I return a cursor index at a given position as a Point provided in local coordinates of this span"
	<return: #Number>
	| aWidth aMeasurer |

	aWidth := aPoint x max: 0.
	aMeasurer := self measurer.

	(aWidth <= 0)
		ifTrue: [ ^ (self from - 1) max: 0 ].
	(aWidth >= self advance)
		ifTrue: [ ^ self to ].

	^ (self spanStart to: self spanEnd)
		findBinary: [ :anIndex |
			| aSubSpan aParagraph |
			
			aSubSpan := BlSpan
				text: (span text from: (1 min: anIndex) to: anIndex)
				attributes: self span attributes.
			
			aParagraph := aMeasurer
				measureSpan: aSubSpan
				on: aCanvas.
			(aWidth - aParagraph width) sign ]
		"exact match"
		do: [ :anIndex | self from + anIndex - 1 ]

		"need to measure a bit more"
		ifNone: [ :a :b |
			| leftIndex rightIndex leftWidth leftSpanIndex rightWidth rightSpanIndex spanIndex |
			leftIndex := a ifNil: [ self spanStart - 1 ].
			rightIndex := b ifNil: [ self spanEnd + 1 ].
			
			leftIndex < self spanStart
				ifTrue: [
					leftWidth := 0.
					leftSpanIndex := (self spanStart - 1) max: 0 ]
				ifFalse: [
					| aSubSpan aParagraph |
					aSubSpan := BlSpan
						text: (span text from: (1 min: leftIndex) to: leftIndex)
						attributes: self span attributes.
					aParagraph := aMeasurer
						measureSpan: aSubSpan
						on: aCanvas.
					leftWidth := aParagraph width.
					leftSpanIndex := leftIndex ].

			rightIndex > self spanEnd
				ifTrue: [
					rightWidth := self advance.
					rightSpanIndex := self spanEnd ]
				ifFalse: [
					| aSubSpan aParagraph |
					aSubSpan := BlSpan
						text: (span text from: (1 min: rightIndex) to: rightIndex)
						attributes: self span attributes.
					aParagraph := aMeasurer
						measureSpan: aSubSpan
						on: aCanvas.
					rightWidth := aParagraph width.
					rightSpanIndex := rightIndex ].

			spanIndex := aWidth <= (leftWidth + ((rightWidth - leftWidth) / 2.0))
				ifTrue: [ leftSpanIndex ]
				ifFalse: [ rightSpanIndex ].

			self from + spanIndex - 1 ]
]

{ #category : #initialization }
BlTextParagraphSpan >> initialize [
	super initialize.
	
	isVertical := false
]

{ #category : #testing }
BlTextParagraphSpan >> isSplitted [
	"Return true if span I measure is splitted right after me. This may happen
	if a single span does not fit in a line and we have to push next paragraph span
	on the next paragraph line"
	<return: #Boolean>
	
	^ spanEnd < span size
]

{ #category : #testing }
BlTextParagraphSpan >> isVertical [
	^ isVertical
]

{ #category : #accessing }
BlTextParagraphSpan >> measurer [
	^ measurer
]

{ #category : #initialization }
BlTextParagraphSpan >> measurer: aSpanMeasurer [
	measurer := aSpanMeasurer
]

{ #category : #accessing }
BlTextParagraphSpan >> metrics [
	^ super metrics, { 'Advance' -> self advance }
]

{ #category : #measurement }
BlTextParagraphSpan >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	| newLeft newTop |

	newLeft := left floorTicks: aScale.
	newTop := top floorTicks: aScale.

	width := (left - newLeft + width) ceilingTicks: aScale.
	height := (top - newTop + height) ceilingTicks: aScale.

	left := newLeft.
	top := newTop.

	advance := advance ceilingTicks: aScale
]

{ #category : #geometry }
BlTextParagraphSpan >> positionAt: anIndex [
	self deprecated: 'Use positionAt:on:'
]

{ #category : #geometry }
BlTextParagraphSpan >> positionAt: anIndex on: aCanvas [
	<return: #Point>
	| aSpanIndex aSubSpan aMeasuredSpan aMeasurer aPositionY aPositionX |

	aPositionY := self baseline y.
	aPositionX := self baseline x.

	(anIndex = (self from - 1))
		ifTrue: [ ^ aPositionX @ aPositionY ].
	(anIndex = self to)
		ifTrue: [ ^ (aPositionX + self advance) @ aPositionY ].

	aSpanIndex := anIndex - self from + 1.
	aSpanIndex isZero
		ifTrue: [ ^ aPositionX @ aPositionY ].

	aMeasurer := self measurer.

	aSubSpan := BlSpan
		text: (span text from: (1 min: aSpanIndex) to: aSpanIndex)
		attributes: self span attributes.

	aMeasuredSpan := aMeasurer
		measureSpan: aSubSpan
		on: aCanvas.
		
	^ (aPositionX + aMeasuredSpan width) @ aPositionY
]

{ #category : #printing }
BlTextParagraphSpan >> printOn: aStream [
	span
		ifNil: [ aStream nextPutAll: '(not yet initialized)' ]
		ifNotNil: [ span printOn: aStream from: spanStart to: spanEnd ]
]

{ #category : #'accessing - span' }
BlTextParagraphSpan >> span [
	"Return an underlying text span that I represent"
	<return: #BlSpan>
	
	self assertSpan.

	^ span
]

{ #category : #initialization }
BlTextParagraphSpan >> span: aBrSpan start: aSpanStart end: aSpanEnd [
	"Assign an attributed text span with corresponding start and end indices which I measure"
	
	span := aBrSpan.
	spanStart := aSpanStart.
	spanEnd := aSpanEnd.
	
	self assertSpan
]

{ #category : #'accessing - span' }
BlTextParagraphSpan >> spanEnd [
	<return: #Number>

	^ spanEnd
]

{ #category : #'accessing - span' }
BlTextParagraphSpan >> spanLength [
	<return: #Number>

	^ (spanStart isZero and: [ spanEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ spanEnd - spanStart + 1 ]
]

{ #category : #'accessing - span' }
BlTextParagraphSpan >> spanStart [
	<return: #Number>

	^ spanStart
]

{ #category : #accessing }
BlTextParagraphSpan >> strikethroughOffset [
	^ strikethroughOffset
]

{ #category : #accessing }
BlTextParagraphSpan >> strikethroughSize [
	^ strikethroughSize
]

{ #category : #initialization }
BlTextParagraphSpan >> text: aBrText from: aGlobalTextStart to: aGlobalTextEnd [
	"Assign the paragraph's text with provided indices so that we could always determine which part of it I measure"

	from := aGlobalTextStart.
	to := aGlobalTextEnd
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRun [
	
	self assertTextRun.
	
	^ textRun
]

{ #category : #initialization }
BlTextParagraphSpan >> textRun: aTextRun start: aTextRunStart end: aTextRunEnd [
	"Assign a backend specific text run (collection of glyphs) with corresponding
	start and end indices which represents an unstyled piece of text"
	
	textRun := aTextRun.
	textRunStart := aTextRunStart.
	textRunEnd := aTextRunEnd.
	
	self assertTextRun
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRunEnd [
	"Return an index of a last measured glyph in a text run that should be rendered"
	<return: #Number>
	self assertTextRun.
	
	^ textRunEnd
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRunLength [
	"Return how many glyphs I represent of a text run according
	to text run start and end indices. It is guaranteed that during
	rendering only this amount of glyphs will be rendered.
	Note: glyphs can be complex, meaning that they consist of multiple simple glyphs,
	that is why text run length always equal or greater than span length"
	<return: #Number>
	self assertTextRun.
	
	^ (textRunStart isZero and: [ textRunEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ textRunEnd - textRunStart + 1 ]
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRunStart [
	"Return an index of a first measured glyph in a text run that should be rendered"
	<return: #Number>
	self assertTextRun.
	
	^ textRunStart
]
