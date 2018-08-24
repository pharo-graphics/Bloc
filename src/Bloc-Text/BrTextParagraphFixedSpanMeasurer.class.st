"
I am a span measurer that assignes a fixed extent to every text character ignoring text attributes.

Useful for testing the paragraph behaviour
"
Class {
	#name : #BrTextParagraphFixedSpanMeasurer,
	#superclass : #BrTextParagraphSpanMeasurer,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'ascent',
		'descent',
		'glyphWidth',
		'height',
		'measuredWidth',
		'measuredHeight',
		'textParagraph',
		'textSpan',
		'textRun',
		'textRunStart',
		'textRunEnd'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #measurement }
BrTextParagraphFixedSpanMeasurer >> applyMetricsOn: aParagraphSpan [
	"Apply metrics on a given paragrah span taking into account its transformation if one exists"
	
	aParagraphSpan applyFixedMetrics: self
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> ascent: aNumber [
	ascent := aNumber
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> descent [
	<return: #Number>

	^ descent
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> descent: aNumber [
	descent := aNumber
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> glyphWidth [
	<return: #Number>

	^ glyphWidth
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> glyphWidth: aNumber [
	glyphWidth := aNumber
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> height [
	^ height
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> height: aNumber [
	height := aNumber
]

{ #category : #initialization }
BrTextParagraphFixedSpanMeasurer >> initialize [
	super initialize.

	ascent := 11.
	descent := 4.
	height := 13.
	glyphWidth := 5
]

{ #category : #measurement }
BrTextParagraphFixedSpanMeasurer >> measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth [
	| metricsLength howManyGlyphsFit measuredLength |
	"Measure a given text run from provided start to the end indices limiting available with to aWidth"

	self
		assert: [ aTextRun isNotEmpty or: [ aTextRunStart isZero and: [ aTextRunEnd isZero ] ] ]
		description: [ 'If text run is empty start and end indices must be zero (end may be infinite)' ].

	self
		assert: [ aTextRunStart isInfinite not ]
		description: [ 'Text run start must be finite' ].

	self
		assert: [ (aTextRunStart between: 1 and: aTextRun size) or: [ aTextRun isEmpty ] ]
		description: [ 'Text run start must be less or equal to text run length' ].

	self
		assert: [ aTextRunEnd isInfinite not ]
		description: [ 'Text run end must be finite' ].

	self
		assert: [ (aTextRunEnd between: 1 and: aTextRun size) or: [ aTextRun isEmpty ] ]
		description: [ 'Text run end must be less or equal to text run length' ].
	
	metricsLength := aTextRun isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ aTextRunEnd - aTextRunStart + 1 ].
	
	howManyGlyphsFit := aWidth isInfinite
		ifTrue: [ metricsLength ]
		ifFalse: [ (aWidth / self glyphWidth) ceiling ].

	measuredLength := metricsLength min: howManyGlyphsFit.
	measuredWidth := measuredLength * self glyphWidth.
	measuredHeight := self height * measuredLength isZero not asBit.
	
	textRunStart := aTextRunStart.
	textRunEnd := aTextRunStart + measuredLength - aTextRun isNotEmpty asBit.
]

{ #category : #dispatch }
BrTextParagraphFixedSpanMeasurer >> measureTextParagraph: aBrTextParagraph [
	aBrTextParagraph
		measureOn: self
		with: self
]

{ #category : #metrics }
BrTextParagraphFixedSpanMeasurer >> measuredHeight [
	^ measuredHeight
]

{ #category : #metrics }
BrTextParagraphFixedSpanMeasurer >> measuredWidth [
	^ measuredWidth
]

{ #category : #initialization }
BrTextParagraphFixedSpanMeasurer >> reset [
	super reset.
	
	measuredWidth := nil.
	measuredHeight := nil.
	textRunStart := nil.
	textRunEnd := nil
]

{ #category : #initialization }
BrTextParagraphFixedSpanMeasurer >> span: aBrSpan of: aTextParagraph on: aCanvas [
	"Prepare and configure me for a given text span within a paragraph"

	textParagraph := aTextParagraph.
	textSpan := aBrSpan.
	textRun := aBrSpan asString.
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> spanEnd [
	"Return an index of a last letter in a original text span that fit in a requested width
	during last measurement process"
	<return: #Number>
	
	^ textRunEnd
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> spanStart [
	"Return an index of a first letter in a original text span that was measured during last measurement process"
	<return: #Number>

	^ textRunStart
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> textRun [
	"Return a text run for a current text span"
	<return: #String>

	^ textRun
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> textRunEnd [
	"Return an index of a last glyph that fits within a limited width set during last measurement process"
	<return: #Number>

	^ textRunEnd
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> textRunLength [
	"Return a total amount of glyphs (not characters!) in a text run"
	<return: #Number>

	^ textRun size
]

{ #category : #accessing }
BrTextParagraphFixedSpanMeasurer >> textRunStart [
	"Return an index of a first glyph that was measure during previous measurement process"
	<return: #Number>

	^ textRunStart
]

{ #category : #metrics }
BrTextParagraphFixedSpanMeasurer >> width [
	"Return a measured width of a text run"
	<return: #Number>

	^ measuredWidth
]
