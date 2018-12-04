"
I define a backend independent API of a single paragraph span measurer.

My responsibility is to measure a given paragraph span according to provided properties
"
Class {
	#name : #BlTextParagraphSpanMeasurer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'textParagraph',
		'textSpan'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #measurement }
BlTextParagraphSpanMeasurer >> applyMetricsOn: aParagraphSpan [
	"Apply metrics on a given paragrah span taking into account its transformation if one exists"
	
	^ self subclassResponsibility
]

{ #category : #measurement }
BlTextParagraphSpanMeasurer >> measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth [
	"Measure a given text run from provided start to the end indices limiting available with to aWidth"

	self subclassResponsibility
]

{ #category : #measurement }
BlTextParagraphSpanMeasurer >> measureSpan: aParagraphSpan from: aTextRunStart to: aTextRunEnd width: aWidth [
	"Measure a text run of a given paragraph span from provided text run start to the text run end indices limiting available with to aWidth"

	textSpan := aParagraphSpan span.
	self
		measure: aParagraphSpan textRun
		from: aTextRunStart
		to: aTextRunEnd
		width: aWidth
]

{ #category : #initialization }
BlTextParagraphSpanMeasurer >> reset [
]

{ #category : #initialization }
BlTextParagraphSpanMeasurer >> span: aBrSpan of: aTextParagraph on: aCanvas [
	"Prepare and configure me for a given text span within a paragraph"

	self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphSpanMeasurer >> spanEnd [
	"Return an index of a last letter in a original text span that fit in a requested width
	during last measurement process"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphSpanMeasurer >> spanStart [
	"Return an index of a first letter in a original text span that was measured during last measurement process"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphSpanMeasurer >> textRun [
	"Return a text run for a current text span"
	<return: #Object>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphSpanMeasurer >> textRunEnd [
	"Return an index of a last glyph that fits within a limited width set during last measurement process"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphSpanMeasurer >> textRunLength [
	"Return a total amount of glyphs (not characters!) in a text run"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphSpanMeasurer >> textRunStart [
	"Return an index of a first glyph that was measured during previous measurement process"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #metrics }
BlTextParagraphSpanMeasurer >> width [
	"Return a measured width of a text run"
	<return: #Number>

	^ self subclassResponsibility
]
