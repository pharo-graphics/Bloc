"
I measure a text span in a context of sparta canvas
"
Class {
	#name : #BrTextParagraphSpanSpartaMeasurer,
	#superclass : #BlTextParagraphSpanMeasurer,
	#instVars : [
		'textRun',
		'textRunIterator',
		'metrics',
		'textRunStart',
		'textRunEnd',
		'spanStart',
		'spanEnd',
		'textParagraph',
		'textSpan'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #measurement }
BrTextParagraphSpanSpartaMeasurer >> applyMetricsOn: aParagraphSpan [
	"Apply metrics on a given paragrah span taking into account its transformation if one exists"
	
	aParagraphSpan applySpartaMetrics: metrics
]

{ #category : #measurement }
BrTextParagraphSpanSpartaMeasurer >> measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth [
	| aSpanIterator metricsLength skipLength currentEnd actualEnd actualEndChanged |
	"Measure a given text run from provided start to the end indices limiting available with to aWidth"
	
	self
		assert: [ aTextRun isNotEmpty or: [ aTextRunStart isZero and: [ aTextRunEnd isZero ] ] ]
		description: [ 'If text run is empty start and end indices must be zero (end may be infinite)' ].
	
	self
		assert: [ aTextRunStart isInfinite not ]
		description: [ 'Text run start must be finite' ].

	self
		assert: [ (aTextRunStart between: 1 and: aTextRun size) or: [ aTextRun isEmpty ] ]
		description: [ 'Text run start must be less or equal to text run size (amount of glyphs)' ].

	self
		assert: [ aTextRunEnd isInfinite not ]
		description: [ 'Text run end must be finite' ].
		
	self
		assert: [ (aTextRunEnd between: 1 and: aTextRun size) or: [ aTextRun isEmpty ] ]
		description: [ 'Text run end must be less or equal to text run size (amount of glyphs)' ].

	metricsLength := aTextRun isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ aTextRunEnd - aTextRunStart + 1 ].

	metrics width: aWidth.
	metrics start: aTextRunStart.
	metrics length: metricsLength.

	aTextRun measureOn: metrics.

	textRunStart := aTextRunStart.
	textRunEnd := (metrics wrappedEnd max: 0).

	spanStart := textRunIterator position.
	skipLength := aTextRun isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ textRunEnd - textRunStart + 1 ].
	textRunIterator skipUnits: skipLength.
	spanEnd := textRunIterator position.
	
	aSpanIterator := textSpan iterator: spanStart to: textSpan size.
	currentEnd := spanStart.
	actualEnd := spanStart.
	actualEndChanged := false.
	[ aSpanIterator hasNext and: [ currentEnd < spanEnd ] ]
		whileTrue: [ (aSpanIterator next = Character tab)
			ifTrue: [ currentEnd := currentEnd + textParagraph tabWidth ]
			ifFalse: [ currentEnd := currentEnd + 1 ].
			actualEnd := actualEnd + 1.
			actualEndChanged := true ].
		
	spanEnd := actualEnd - actualEndChanged asBit
]

{ #category : #initialization }
BrTextParagraphSpanSpartaMeasurer >> reset [
	textRunIterator := textRun iterator
]

{ #category : #initialization }
BrTextParagraphSpanSpartaMeasurer >> span: aBrSpan of: aTextParagraph on: aSpartaCanvas [
	"Prepare and configure me for a given text span within a paragraph"
	| aTextPainter |

	aTextPainter := aTextParagraph
		createSpartaTextPainter: aBrSpan
		on: aSpartaCanvas.

	textRun := aTextPainter textRun.

	self
		assert: [ textRun isNull not ]
		description: [ 'Created text run must not be nullptr' ].
	
	aTextParagraph wantsAutoRelease
		ifTrue: [ textRun autoRelease ].

	textRunIterator := textRun iterator.
	metrics := aTextPainter metrics.
	textParagraph := aTextParagraph.
	textSpan := aBrSpan
]

{ #category : #accessing }
BrTextParagraphSpanSpartaMeasurer >> spanEnd [
	"Return an index of a last letter in a original text span that fit in a requested width
	during last measurement process"
	<return: #Number>
	
	^ spanEnd
]

{ #category : #accessing }
BrTextParagraphSpanSpartaMeasurer >> spanStart [
	"Return an index of a first letter in a original text span that was measured during last measurement process"
	<return: #Number>

	^ spanStart
]

{ #category : #accessing }
BrTextParagraphSpanSpartaMeasurer >> textRun [
	"Return a text run for a current text span"
	<return: #Object>
	
	^ textRun
]

{ #category : #accessing }
BrTextParagraphSpanSpartaMeasurer >> textRunEnd [
	"Return an index of a last glyph that fits within a limited width set during last measurement process"
	<return: #Number>

	^ textRunEnd
]

{ #category : #accessing }
BrTextParagraphSpanSpartaMeasurer >> textRunLength [
	"Return a total amount of glyphs (not characters!) in a text run"
	<return: #Number>

	^ textRun size
]

{ #category : #accessing }
BrTextParagraphSpanSpartaMeasurer >> textRunStart [
	"Return an index of a first glyph that was measure during previous measurement process"
	<return: #Number>

	^ textRunStart
]

{ #category : #metrics }
BrTextParagraphSpanSpartaMeasurer >> width [
	"Return a measured width of a text run"
	<return: #Number>

	^ metrics textMetrics advance
]
