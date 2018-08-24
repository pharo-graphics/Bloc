"
I define a backend independent API of a single paragraph span measurer.

My responsibility is to measure a given paragraph span according to provided properties
"
Class {
	#name : #BrTextParagraphSpanMeasurer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #measurement }
BrTextParagraphSpanMeasurer >> applyMetricsOn: aParagraphSpan [
	"Apply metrics on a given paragrah span taking into account its transformation if one exists"
	
	^ self subclassResponsibility
]

{ #category : #measurement }
BrTextParagraphSpanMeasurer >> measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth [
	"Measure a given text run from provided start to the end indices limiting available with to aWidth"

	self subclassResponsibility
]

{ #category : #initialization }
BrTextParagraphSpanMeasurer >> reset [
]

{ #category : #initialization }
BrTextParagraphSpanMeasurer >> span: aBrSpan of: aTextParagraph on: aCanvas [
	"Prepare and configure me for a given text span within a paragraph"

	self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphSpanMeasurer >> spanEnd [
	"Return an index of a last letter in a original text span that fit in a requested width
	during last measurement process"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphSpanMeasurer >> spanStart [
	"Return an index of a first letter in a original text span that was measured during last measurement process"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphSpanMeasurer >> textRun [
	"Return a text run for a current text span"
	<return: #Object>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphSpanMeasurer >> textRunEnd [
	"Return an index of a last glyph that fits within a limited width set during last measurement process"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphSpanMeasurer >> textRunLength [
	"Return a total amount of glyphs (not characters!) in a text run"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphSpanMeasurer >> textRunStart [
	"Return an index of a first glyph that was measured during previous measurement process"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #metrics }
BrTextParagraphSpanMeasurer >> width [
	"Return a measured width of a text run"
	<return: #Number>

	^ self subclassResponsibility
]
