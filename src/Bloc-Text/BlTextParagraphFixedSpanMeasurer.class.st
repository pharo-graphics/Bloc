"
I am a span measurer that assignes a fixed extent to every text character ignoring text attributes.

Useful for testing the paragraph behaviour
"
Class {
	#name : #BlTextParagraphFixedSpanMeasurer,
	#superclass : #BlTextParagraphSpanMeasurer,
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
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #measurement }
BlTextParagraphFixedSpanMeasurer >> applyMetricsOn: aParagraphSpan [
	"Apply metrics on a given paragrah span taking into account its transformation if one exists"
	
	aParagraphSpan applyFixedMetrics: self
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> ascent: aNumber [
	ascent := aNumber
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> descent [
	<return: #Number>

	^ descent
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> descent: aNumber [
	descent := aNumber
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> glyphWidth [
	<return: #Number>

	^ glyphWidth
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> glyphWidth: aNumber [
	glyphWidth := aNumber
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> height [
	^ height
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> height: aNumber [
	height := aNumber
]

{ #category : #initialization }
BlTextParagraphFixedSpanMeasurer >> initialize [
	super initialize.

	ascent := 11.
	descent := 4.
	height := 13.
	glyphWidth := 5
]

{ #category : #measurement }
BlTextParagraphFixedSpanMeasurer >> measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth [
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
BlTextParagraphFixedSpanMeasurer >> measureTextParagraph: aBrTextParagraph [
	aBrTextParagraph
		measureOn: self
		with: self
]

{ #category : #metrics }
BlTextParagraphFixedSpanMeasurer >> measuredHeight [
	^ measuredHeight
]

{ #category : #metrics }
BlTextParagraphFixedSpanMeasurer >> measuredWidth [
	^ measuredWidth
]

{ #category : #initialization }
BlTextParagraphFixedSpanMeasurer >> reset [
	super reset.
	
	measuredWidth := nil.
	measuredHeight := nil.
	textRunStart := nil.
	textRunEnd := nil
]

{ #category : #initialization }
BlTextParagraphFixedSpanMeasurer >> span: aBrSpan of: aTextParagraph on: aCanvas [
	"Prepare and configure me for a given text span within a paragraph"

	textParagraph := aTextParagraph.
	textSpan := aBrSpan.
	textRun := aBrSpan asString.
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> spanEnd [
	"Return an index of a last letter in a original text span that fit in a requested width
	during last measurement process"
	<return: #Number>
	
	^ textRunEnd
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> spanStart [
	"Return an index of a first letter in a original text span that was measured during last measurement process"
	<return: #Number>

	^ textRunStart
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> textRun [
	"Return a text run for a current text span"
	<return: #String>

	^ textRun
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> textRunEnd [
	"Return an index of a last glyph that fits within a limited width set during last measurement process"
	<return: #Number>

	^ textRunEnd
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> textRunLength [
	"Return a total amount of glyphs (not characters!) in a text run"
	<return: #Number>

	^ textRun size
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> textRunStart [
	"Return an index of a first glyph that was measure during previous measurement process"
	<return: #Number>

	^ textRunStart
]

{ #category : #metrics }
BlTextParagraphFixedSpanMeasurer >> width [
	"Return a measured width of a text run"
	<return: #Number>

	^ measuredWidth
]
