"
I am text paragraph measurer. I keep track of available width, height, current measuring position.

Additionally, depending on a paragraph type I may collect lines or spans. This behaviour should be inplemented in my paragraph sepecific subclass.
"
Class {
	#name : #BrTextParagraphMeasurer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'maxHeight',
		'maxWidth',
		'span',
		'text',
		'textRun',
		'textRunStart',
		'textRunEnd',
		'textRunSize',
		'spanStart',
		'spanEnd',
		'textPosition'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BrTextParagraphMeasurer >> accumulatedHeight [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraphMeasurer >> accumulatedWidth [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'geometry - accessing' }
BrTextParagraphMeasurer >> availableHeight [
	^ maxHeight - self accumulatedHeight
]

{ #category : #'geometry - accessing' }
BrTextParagraphMeasurer >> availableWidth [
	^ maxWidth - self accumulatedWidth
]

{ #category : #initialization }
BrTextParagraphMeasurer >> defaultParagraphSpan [
	^ BrTextParagraphSpan new
]

{ #category : #'measurement - testing' }
BrTextParagraphMeasurer >> hasAvailableSpace [
	"Return true if I have space available for more spans, false otherwise"
	<return: #Boolean>

	^ self availableWidth > 0
]

{ #category : #initialization }
BrTextParagraphMeasurer >> initialize [
	super initialize.
	
	maxWidth := Float infinity.
	maxHeight := Float infinity.
	textPosition := 0
]

{ #category : #adding }
BrTextParagraphMeasurer >> initializeSpan: aParagraphSpan [
	"Initialize a given paragraph span with a corresponding text, text run
	and their start and end indices"

	aParagraphSpan
		textRun: self textRun
		start: self textRunStart
		end: self textRunEnd.

	aParagraphSpan
		span: self span
		start: self spanStart
		end: self spanEnd.
		
	aParagraphSpan
		text: self text
		from: self textStart
		to: self textEnd.
]

{ #category : #'paragraph - properties' }
BrTextParagraphMeasurer >> maxHeight [
	^ maxHeight
]

{ #category : #'paragraph - properties' }
BrTextParagraphMeasurer >> maxHeight: aNumber [
	maxHeight := aNumber
]

{ #category : #'paragraph - properties' }
BrTextParagraphMeasurer >> maxWidth [
	^ maxWidth
]

{ #category : #'paragraph - properties' }
BrTextParagraphMeasurer >> maxWidth: aNumber [
	maxWidth := aNumber
]

{ #category : #measurement }
BrTextParagraphMeasurer >> measureSpan: aBrSpan of: aTextParagraph on: aCanvas with: aSpanMeasurer [

	self
		assert: [ self text isEmpty or: [ self text isNotEmpty and: [ aBrSpan isNotEmpty ] ] ]
		description: [ 'Span must not be empty if original text is not empty' ].
	self
		assert: [ self text isNotEmpty or: [ self text isEmpty and: [ aBrSpan isEmpty ] ] ]
		description: [ 'Span must be empty if original text is empty' ].
	
	"initialize a span measurer with span, text paragraph and canvas"
	aSpanMeasurer
		span: aBrSpan
		of: aTextParagraph
		on: aCanvas.

	"// CONFIG: Switch my context by setting span and text run that we want to measure "
	self span: aBrSpan.
	self textRun: aSpanMeasurer textRun.

	[ self wantsMore ] whileTrue: [
		| aParagraphSpan |

		aParagraphSpan := self defaultParagraphSpan.
		aParagraphSpan measurer: aSpanMeasurer.

		aSpanMeasurer
			measure: self textRun
			from: self textRunStart
			to: aSpanMeasurer textRunLength
			width: self availableWidth.
		
		self textRunStart: aSpanMeasurer textRunStart.
		self textRunEnd: aSpanMeasurer textRunEnd.
		
		self
			assert: [ (self textRunStart isZero and: [ self textRunEnd isZero ]) or: [ self textRunStart > 0 ] ]
			description: [ 'If text run start is zero, then text end must be zero too' ].

		self spanStart: aSpanMeasurer spanStart.
		self spanEnd: aSpanMeasurer spanEnd.

		self initializeSpan: aParagraphSpan.
		aSpanMeasurer applyMetricsOn: aParagraphSpan.
		self pushSpan: aParagraphSpan ]
]

{ #category : #accessing }
BrTextParagraphMeasurer >> movePosition: aNumber [
	textPosition := aNumber
]

{ #category : #'text - accessing' }
BrTextParagraphMeasurer >> position [
	^ textPosition
]

{ #category : #accessing }
BrTextParagraphMeasurer >> pushPosition: aNumber [
	textPosition := textPosition + aNumber
]

{ #category : #adding }
BrTextParagraphMeasurer >> pushSpan: aSpan [
	self subclassResponsibility
]

{ #category : #'span - accessing' }
BrTextParagraphMeasurer >> span [
	"Return a text span that I cuurently measure"
	<return: #BlSpan>

	^ span
]

{ #category : #'span - accessing' }
BrTextParagraphMeasurer >> span: aBrSpan [
	"Set text span that should be measured"

	span := aBrSpan
]

{ #category : #'span - accessing' }
BrTextParagraphMeasurer >> spanEnd [
	^ spanEnd
]

{ #category : #'span - accessing' }
BrTextParagraphMeasurer >> spanEnd: anIndex [
	spanEnd := anIndex
]

{ #category : #'span - accessing' }
BrTextParagraphMeasurer >> spanLength [
	^ self spanEnd - self spanStart + 1
]

{ #category : #'span - accessing' }
BrTextParagraphMeasurer >> spanStart [
	^ spanStart
]

{ #category : #'span - accessing' }
BrTextParagraphMeasurer >> spanStart: anIndex [
	spanStart := anIndex
]

{ #category : #'text - accessing' }
BrTextParagraphMeasurer >> text [
	^ text
]

{ #category : #'text - accessing' }
BrTextParagraphMeasurer >> text: aBrText [
	text := aBrText
]

{ #category : #'text - accessing' }
BrTextParagraphMeasurer >> textEnd [
	^ self textPosition + self spanLength - 1
]

{ #category : #'text - accessing' }
BrTextParagraphMeasurer >> textPosition [
	^ textPosition
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRun [
	"Return a backend specific collection of glyphs, which are currently measured"
	<return: #Object>

	^ textRun
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRun: aTextRun [
	"Set a text run (a collection of glyphs) that should be measured"
	
	textRun := aTextRun.
	textRunStart := aTextRun isNotEmpty asBit.
	textRunSize := textRun size.
	textRunEnd := 0
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRunEnd [
	"Return an index of a last measured glyph"
	<return: #Number>

	^ textRunEnd
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRunEnd: aNumber [
	"Set an index of a last measured glyph"
	
	textRunEnd := aNumber
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRunLength [
	"Return amount of measured glyph processed during last measurement cycle"
	<return: #Object>

	^ self textRunEnd - self textRunStart + 1
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRunSize [
	"Return total amount of glyphs to be measured if there is enough space"
	<return: #Object>

	^ textRunSize
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRunStart [
	"Return a glyph index within a text run from which measurement should start"
	<return: #Number>

	^ textRunStart
]

{ #category : #'text run - accessing' }
BrTextParagraphMeasurer >> textRunStart: aNumber [
	"Set a glyph index within a text run from which measurement should start"
	
	textRunStart := aNumber
]

{ #category : #'text - accessing' }
BrTextParagraphMeasurer >> textSize [
	^ self text size
]

{ #category : #'text - accessing' }
BrTextParagraphMeasurer >> textStart [
	^ self textPosition
]

{ #category : #'measurement - testing' }
BrTextParagraphMeasurer >> wantsMore [
	"Return true if I there is enough space left or there are still not measured glyphs in a text run,
	false otherwise"
	<return: #Boolean>
	
	self
		assert: [ self text isNotEmpty or: [ self textRunStart isZero and: [ self textRunSize isZero ] ] ]
		description: [ 'If text is empty start and size must be zero' ].
		
	^ self text isEmpty
		ifTrue: [ false ]
		ifFalse: [ self textRunStart <= self textRunSize and: [ self availableWidth > 0 ] ]
]
