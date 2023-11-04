"
I represent a list of consecutive spans of a BlTextParagraph.

My width is not a plain sum of width of all spans. The difference comes from the fact that because of Kerning advance of a piece of text is less than visual width of the same text.

"
Class {
	#name : 'BlTextParagraphLine',
	#superclass : 'BlTextParagraphSegment',
	#instVars : [
		'spans'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Paragraph',
	#package : 'Bloc-Text',
	#tag : 'Text-Paragraph'
}

{ #category : 'adding' }
BlTextParagraphLine >> addSpan: aBlTextParagraphLeaf [

	spans add: aBlTextParagraphLeaf.
	spans size = 1
		ifTrue: [ self spanAdded: spans first ]
		ifFalse: [ self spanAdded: spans last after: (spans at: spans size - 1) ]
]

{ #category : 'accessing' }
BlTextParagraphLine >> baseline: aPoint [

	self moveSpansBy: self baseline negated.
	super baseline: aPoint.
	self moveSpansBy: self baseline
]

{ #category : 'finalization' }
BlTextParagraphLine >> finalize [

	spans ifNotNil: [ spans do: #finalize ].
	spans reset
]

{ #category : 'initialization' }
BlTextParagraphLine >> initialize [

	super initialize.
	spans := OrderedCollection new
]

{ #category : 'testing' }
BlTextParagraphLine >> isEmpty [
	
	^ spans isEmpty
]

{ #category : 'private' }
BlTextParagraphLine >> moveSpansBy: aPoint [
	"Move baseline of all spans by a given delta as a point"

	spans do: [ :aSpan | aSpan baseline: aSpan baseline + aPoint ]
]

{ #category : 'measurement' }
BlTextParagraphLine >> normalize: aScale [
	"Normalize this segment to have rounded measurements.
	I don't change the baseline"

	spans ifEmpty: [ ^ self ].
	spans do: [ :aSpan | aSpan normalize: aScale ].
	self recomputeLineLayout
]

{ #category : 'measurement' }
BlTextParagraphLine >> recomputeLineLayout [

	self spans ifEmpty: [ ^ self ].

	self spanAdded: self spans first.
	2 to: self spans size do: [ :index | 
		self
			spanAdded: (self spans at: index)
			after: (self spans at: index - 1) ]
]

{ #category : 'finalization' }
BlTextParagraphLine >> reset [

	self finalize

]

{ #category : 'hooks' }
BlTextParagraphLine >> spanAdded: aSpan [
	"React to a span added. Note: aSpan must be the first span."

	left := aSpan left.
	top := aSpan top.
	width := aSpan width.
	height := aSpan height.
	advance := aSpan advance.
	
	ascent := aSpan ascent.
	descent := aSpan descent.

	from := aSpan from.
	to := aSpan to.
	
	aSpan baseline: self baseline
]

{ #category : 'hooks' }
BlTextParagraphLine >> spanAdded: aLastSpan after: aPreviousSpan [

	| previousBottom newBottom |

	aLastSpan baseline: aPreviousSpan baseline + (aPreviousSpan advance @ 0).

	previousBottom := top + height.
	newBottom := aLastSpan top + aLastSpan height.
	top := top min: aLastSpan top.
	height := height max: ((previousBottom max: newBottom) - top).

	width := aLastSpan baseline x + aLastSpan left + aLastSpan width.
	advance := advance + aLastSpan advance.

	ascent := ascent min: aLastSpan ascent.
	descent := descent max: aLastSpan descent.

	to := aLastSpan to
]

{ #category : 'accessing' }
BlTextParagraphLine >> spans [

	^ spans 
]
