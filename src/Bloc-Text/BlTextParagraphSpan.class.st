"
I represent a single measured span within `=BrTextParagraph`=.
Depending on the type of a paragraph (single or multi line) I can be either a direct child of `=BrTextParagraph`= or be contained inside of `=BrTextParagraphLine`=.

A span consists of 3 essential parts:

	- underlying text span with span start and end indices
	- generated glyph text run with start and end indices used for measurement and rendering
	- various measurement metrics computed during measurement step by `=BrTextParagraphSpanMeasurer`=

"
Class {
	#name : 'BlTextParagraphSpan',
	#superclass : 'BlTextParagraphSegment',
	#instVars : [
		'textRun',
		'span',
		'measurer',
		'strikethroughOffset',
		'strikethroughSize',
		'isVertical'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : 'accessing' }
BlTextParagraphSpan >> advance [
	<return: #Number>

	^ advance
]

{ #category : 'initialization' }
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

{ #category : 'accessing - span' }
BlTextParagraphSpan >> attributes [
	"Return a set of attributes applied on this span"
	<return: #Set of: #BlTextAttribute>

	^ span attributes
]

{ #category : 'finalization' }
BlTextParagraphSpan >> finalize [

	textRun ifNotNil: [ :aTextRun | aTextRun release ].
	textRun := nil
]

{ #category : 'geometry' }
BlTextParagraphSpan >> indexAtPosition: aPoint [
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
			
			aParagraph := aMeasurer measureTextSpan: aSubSpan.
			
			(aWidth closeTo: aParagraph advance epsilon: 0.1)
				ifTrue: [ 0 ]
				ifFalse: [ (aWidth - aParagraph advance) sign ] ]
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
					aParagraph := aMeasurer measureTextSpan: aSubSpan.
					leftWidth := aParagraph advance.
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
					aParagraph := aMeasurer measureTextSpan: aSubSpan.
					rightWidth := aParagraph advance.
					rightSpanIndex := rightIndex ].

			spanIndex := aWidth <= (leftWidth + ((rightWidth - leftWidth) / 2.0))
				ifTrue: [ leftSpanIndex ]
				ifFalse: [ rightSpanIndex ].

			self from + spanIndex - 1 ]
]

{ #category : 'initialization' }
BlTextParagraphSpan >> initialize [
	super initialize.
	
	isVertical := false
]

{ #category : 'testing' }
BlTextParagraphSpan >> isSplitted [
	"Return true if span I measure is splitted right after me. This may happen
	if a single span does not fit in a line and we have to push next paragraph span
	on the next paragraph line"
	<return: #Boolean>
	
	^ false
]

{ #category : 'testing' }
BlTextParagraphSpan >> isVertical [
	^ isVertical
]

{ #category : 'accessing' }
BlTextParagraphSpan >> measurer [
	^ measurer
]

{ #category : 'initialization' }
BlTextParagraphSpan >> measurer: aSpanMeasurer [
	measurer := aSpanMeasurer
]

{ #category : 'accessing' }
BlTextParagraphSpan >> metrics [
	^ super metrics, { 'Advance' -> self advance }
]

{ #category : 'measurement' }
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

{ #category : 'accessing' }
BlTextParagraphSpan >> paragraph: aTextParagraph [
	super paragraph: aTextParagraph.

	self attributes do: [ :eachAttribute | eachAttribute applyOnTextParagraph: aTextParagraph from: self from to: self to ]
]

{ #category : 'geometry' }
BlTextParagraphSpan >> positionAt: anIndex [
	<return: #Point>
	| aSpanIndex aSubSpan aMeasuredSpan aMeasurer aPositionY aPositionX |

	aPositionY := self baseline y.
	aPositionX := self baseline x.

	(anIndex = (self from - 1))
		ifTrue: [ ^ aPositionX @ aPositionY ].
	(anIndex = self to)
		ifTrue: [ ^ (aPositionX + self advance) @ aPositionY ].

	aSpanIndex := anIndex - self from + 1.

	aMeasurer := self measurer.

	aSubSpan := BlSpan
		text: (span text from: (1 min: aSpanIndex) to: aSpanIndex)
		attributes: self span attributes.

	aMeasuredSpan := aMeasurer measureTextSpan: aSubSpan.
	
	^ (aPositionX + aMeasuredSpan advance) @ aPositionY
]

{ #category : 'printing' }
BlTextParagraphSpan >> printOn: aStream [
	span
		ifNil: [ aStream nextPutAll: '(not yet initialized)' ]
		ifNotNil: [ aStream print: span ]
]

{ #category : 'accessing - span' }
BlTextParagraphSpan >> span [
	"Return an underlying text span that I represent"
	<return: #BlSpan>

	^ span
]

{ #category : 'initialization' }
BlTextParagraphSpan >> span: aBrSpan [
	"Assign an attributed text span with corresponding start and end indices which I measure"
	
	span := aBrSpan
]

{ #category : 'accessing - span' }
BlTextParagraphSpan >> spanEnd [
	<return: #Number>

	^ span size
]

{ #category : 'accessing - span' }
BlTextParagraphSpan >> spanLength [
	<return: #Number>

	^ (self spanStart isZero and: [ self spanEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ self spanEnd - self spanStart + 1 ]
]

{ #category : 'accessing - span' }
BlTextParagraphSpan >> spanStart [
	<return: #Number>

	^ 1 min: span size
]

{ #category : 'accessing' }
BlTextParagraphSpan >> strikethroughOffset [
	^ strikethroughOffset
]

{ #category : 'accessing' }
BlTextParagraphSpan >> strikethroughSize [
	^ strikethroughSize
]

{ #category : 'initialization' }
BlTextParagraphSpan >> text: aBrText from: aGlobalTextStart to: aGlobalTextEnd [
	"Assign the paragraph's text with provided indices so that we could always determine which part of it I measure"

	from := aGlobalTextStart.
	to := aGlobalTextEnd
]

{ #category : 'accessing - text run' }
BlTextParagraphSpan >> textRun [	
	^ textRun
]

{ #category : 'initialization' }
BlTextParagraphSpan >> textRun: aTextRun [
	"Assign a backend specific text run (collection of glyphs) with corresponding
	start and end indices which represents an unstyled piece of text"
	
	textRun := aTextRun.
]

{ #category : 'accessing - text run' }
BlTextParagraphSpan >> textRunEnd [
	"Return an index of a last measured glyph in a text run that should be rendered"
	<return: #Number>
	
	^ textRun size
]

{ #category : 'accessing - text run' }
BlTextParagraphSpan >> textRunLength [
	"Return how many glyphs I represent of a text run according
	to text run start and end indices. It is guaranteed that during
	rendering only this amount of glyphs will be rendered.
	Note: glyphs can be complex, meaning that they consist of multiple simple glyphs,
	that is why text run length always equal or greater than span length"
	<return: #Number>
	
	^ (self textRunStart isZero and: [ self textRunEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ self textRunEnd - self textRunStart + 1 ]
]

{ #category : 'accessing - text run' }
BlTextParagraphSpan >> textRunStart [
	"Return an index of a first measured glyph in a text run that should be rendered"
	<return: #Number>
	
	^ 1 min: textRun size
]
