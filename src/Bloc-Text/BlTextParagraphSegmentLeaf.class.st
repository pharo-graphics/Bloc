"
I represent a single measured span within `BlTextParagraph`.
Depending on the type of a paragraph (single or multi line) I can be either a direct child of `BlTextParagraph` or be contained inside of `BlTextParagraphLine`.
"
Class {
	#name : 'BlTextParagraphSegmentLeaf',
	#superclass : 'BlTextParagraphSegment',
	#instVars : [
		'span',
		'hostMeasurer',
		'fontAndStyleBuilder'
	],
	#category : 'Bloc-Text-Text-Paragraph',
	#package : 'Bloc-Text',
	#tag : 'Text-Paragraph'
}

{ #category : 'accessing - span' }
BlTextParagraphSegmentLeaf >> attributes [
	"Return a set of attributes applied on this span"

	^ span attributes
]

{ #category : 'accessing' }
BlTextParagraphSegmentLeaf >> from: aGlobalTextStart to: aGlobalTextEnd [
	"Assign provided indices so that we could always determine which part of text I measure"

	from := aGlobalTextStart.
	to := aGlobalTextEnd
]

{ #category : 'initialization' }
BlTextParagraphSegmentLeaf >> hostMeasurer: aHostMeasurer [

	hostMeasurer := aHostMeasurer
]

{ #category : 'accessing' }
BlTextParagraphSegmentLeaf >> indexAtPosition: aPoint [
	"Return a cursor index at a given position as a Point provided in local coordinates of this span"

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

			  aParagraph := hostMeasurer measureTextSpan: aSubSpan.

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
					  aParagraph := hostMeasurer measureTextSpan: aSubSpan.
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
					  aParagraph := hostMeasurer measureTextSpan: aSubSpan.
					  rightWidth := aParagraph advance.
					  rightSpanIndex := rightIndex ].

			  spanIndex := aWidth
			               <= (leftWidth + (rightWidth - leftWidth / 2.0))
				               ifTrue: [ leftSpanIndex ]
				               ifFalse: [ rightSpanIndex ].

			  self from + spanIndex - 1 ]
]

{ #category : 'building' }
BlTextParagraphSegmentLeaf >> measure [
	"Calculate span measurement using hostTextMeasurer."

	^ self subclassResponsibility
]

{ #category : 'measurement' }
BlTextParagraphSegmentLeaf >> normalize: aScale [
	"Normalize this segment to have rounded measurements"

]

{ #category : 'geometry' }
BlTextParagraphSegmentLeaf >> positionAt: anIndex [

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

	aMeasuredSpan := hostMeasurer measureTextSpan: aSubSpan.

	^ aPositionX + aMeasuredSpan advance @ aPositionY
]

{ #category : 'printing' }
BlTextParagraphSegmentLeaf >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: span;
		nextPut: $)

]

{ #category : 'accessing' }
BlTextParagraphSegmentLeaf >> span [

	^ span
]

{ #category : 'accessing' }
BlTextParagraphSegmentLeaf >> span: aBlSpan [

	span := aBlSpan.
	
	"Collect font properties and text style from span attributes"
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	self span attributes do: [ :eachAttribute |
		eachAttribute applyOnFontAndStyleBuilder: fontAndStyleBuilder ].

]

{ #category : 'accessing - span' }
BlTextParagraphSegmentLeaf >> spanEnd [

	^ span size
]

{ #category : 'accessing - span' }
BlTextParagraphSegmentLeaf >> spanLength [

	^ (self spanStart isZero and: [ self spanEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ self spanEnd - self spanStart + 1 ]
]

{ #category : 'accessing - span' }
BlTextParagraphSegmentLeaf >> spanStart [

	^ 1 min: span size
]
