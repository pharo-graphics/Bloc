"
I am text paragraph. My main role is to measure text according to given properties or constraints and prepare it for rendering.

The most important properties are maximal width and height. Maximal width is used to wrap a line of text in multiple lines while maximal height prevents text from exceeding an element's boundaries.

Once measurement is done users may ask for computed text extent by sending #extent message.
The measured text layout can be rendered on Canvas by sending #renderOn: with canvas as argument to me.

Public API and Key Messages

- text: initialize me with a given text
- measureOn: measure given rope using provided canvas
- renderOn: render text layout on given canvas
- extent - return measured text extent
- width - return measured text width
- height - return measured text height
- selection - return text selection interval (used to render selction during renderOn:)
 
Internal Representation and Key Implementation Points.

    Instance Variables
	text:		<BlText>
	maxHeight:		<Number>
	maxWidth:		<Number>
	height:		<Number>
	width:		<Number>
	end:		<Number>
	autoRelease:		<Boolean>
	selection: 	<Interval>

"
Class {
	#name : #BlTextParagraph,
	#superclass : #Object,
	#instVars : [
		'text',
		'line',
		'maxHeight',
		'maxWidth',
		'end',
		'session',
		'baselineMeasurer'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'paragraph - geometry' }
BlTextParagraph >> advance [

	^ line advance
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> ascent [
	"Return an ascent of the first line in a paragraph"
	
	^ line ascent
]

{ #category : #accessing }
BlTextParagraph >> baseline [

	<return: #Point>
	baselineMeasurer ifNil: [ ^ 0 @ 0 ].
	^ baselineMeasurer computedBaseline: self
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> baselineChanged [
	"I should be sent when baseline needs to be recomputed"

	line baseline: self baseline
]

{ #category : #'api - instantiation' }
BlTextParagraph >> baselineMeasurer: aBlTextParagraphBaselineMeasurer [

	baselineMeasurer := aBlTextParagraphBaselineMeasurer.
	self baselineChanged
]

{ #category : #'paragraph - measuring' }
BlTextParagraph >> basicMeasureOn: aHostSpanMeasurer [
	"Measure and create lines with text spans from provided text based on attributes and layout properties (maximum width / height)"

	| anIterator paragraphMeasurer |
	paragraphMeasurer := self newParagraphMeasurerOn: aHostSpanMeasurer.
	
	"line must have at leat one span even with empty text"
	text isEmpty ifTrue: [ paragraphMeasurer measureSpan: self emptySpan ].

	anIterator := text iterator.
	[	anIterator hasNext and: [
		line isEmpty or: [
		paragraphMeasurer hasAvailableSpace ] ] ] whileTrue: [
			"If we pass #hasNext check we will definitely move to the next span,
			so can do the same with position"
			paragraphMeasurer
				movePosition: anIterator position + 1;
				measureSpan: anIterator nextSpan ].

	"measurer creates a line with baseline set to 0@0"
	line := paragraphMeasurer line.
	end := line to
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> bottom [
	"Return a visual bottom coordinate of the text (bottom-most rendered pixel)"

	^ self top + self height
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> bounds [
	
	^ line bounds
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> descent [
	"Return an descent of the last line in a paragraph"

	^ line descent
]

{ #category : #'paragraph - measuring' }
BlTextParagraph >> emptySpan [
	^ BlSpan text: BlText empty attributes: #().
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> extent [
	"Return measured extent of the paragraph.
	@see #width and #height to learn more"

	^ self width @ self height
]

{ #category : #finalization }
BlTextParagraph >> finalize [

	super finalize.
	line ifNotNil: #finalize.
	line := nil
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> height [
	"Return measured height of the paragraph.
	Note: height may be greater than maxHeight. This may happen
	if maxHeight is smaller than height of a single line or word or character.
	We want to guarantee that at least something is displayed and measured."

	^ line height
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> indexAtPosition: aPoint [

	| aParagraphSpan aPointInSpan |

	aParagraphSpan := self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #yourself.
	
	aPointInSpan := aPoint - aParagraphSpan baseline.
	
	^ aParagraphSpan indexAtPosition: aPointInSpan
]

{ #category : #initialization }
BlTextParagraph >> initialize [

	super initialize.
	line := BlTextParagraphLine new
]

{ #category : #testing }
BlTextParagraph >> isEmpty [

	^ self line isEmpty
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> left [
	"Return a visual left coordinate of the text (left-most rendered pixel)"

	^ line left
]

{ #category : #accessing }
BlTextParagraph >> line [

	^ line
]

{ #category : #'api - instantiation' }
BlTextParagraph >> maxHeight [

	^ maxHeight
]

{ #category : #'api - instantiation' }
BlTextParagraph >> maxHeight: aNumber [

	maxHeight := aNumber
]

{ #category : #'api - instantiation' }
BlTextParagraph >> maxWidth [

	^ maxWidth
]

{ #category : #'api - instantiation' }
BlTextParagraph >> maxWidth: aNumber [

	maxWidth := aNumber
]

{ #category : #'paragraph - measuring' }
BlTextParagraph >> measureOn: aBlHostTextMeasurer [
	"Measure myself with a given text measurer as a backend-specific context.
	Note: I double dispatch through aBlHostTextMeasurer to support multiple completely different canvases"

	self basicMeasureOn: aBlHostTextMeasurer.

	"we should store a session of the last successful measurement"
	session := Smalltalk session.

	"self normalize: self scale."
	self baselineChanged.

]

{ #category : #accessing }
BlTextParagraph >> measuredEnd [
	"Return a text index of the last measured character.
	Must be equal to the last character of the last span"
	
	^ end
]

{ #category : #'paragraph - measuring' }
BlTextParagraph >> newParagraphMeasurerOn: aHostSpanMeasurer [

	^ BlTextParagraphMeasurer
		  hostTextMeasurer: aHostSpanMeasurer
		  maxWidth: maxWidth
		  maxHeight: maxHeight
]

{ #category : #'paragraph - measuring' }
BlTextParagraph >> normalize: aScale [

	line normalize: aScale
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> positionAt: anIndex [
	"Answer a Point with the position of the character at anIndex."

	| aParagraphSpan |
	aParagraphSpan := self spanAtIndex: anIndex.
	^ aParagraphSpan positionAt: anIndex
]

{ #category : #printing }
BlTextParagraph >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: text;
		nextPut: $)

]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> right [
	"Return a visual right coordinate of the text (right-most rendered pixel)"

	^ self left + self width
]

{ #category : #accessing }
BlTextParagraph >> session [

	^ session
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> spanAtIndex: anIndex [
	<return: #BlTextParagraphSegmentLeaf>

	anIndex isZero
		ifTrue: [ ^ line spans first ].
		
	anIndex = text size
		ifTrue: [ ^ line spans last ].

	^ line spans
		findBinary: [ :aParagraphSpan |
			(anIndex between: aParagraphSpan from and: aParagraphSpan to )
				ifTrue: [ 0 ]
				ifFalse: [ | spanCenter |
					spanCenter := aParagraphSpan from + ((aParagraphSpan to - aParagraphSpan from) // 2).
					anIndex < spanCenter
						ifTrue: [ -1 ]
						ifFalse: [ 1 ] ] ]
		ifNone: [ self error: 'Span for character at index ', anIndex asString, ' does not exist' ]
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> spanAtPoint: aPoint [
	<return: #BlTextParagraphSegmentLeaf>
	
	^ self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #yourself
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> spanAtPoint: aPoint ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Find a paragraph span that contains a given point given in a paragraph coordinates
	and evaluate a found block if such span was found or evaluate an exception block
	with the closest span to a point"
	<return: #BlTextParagraphSegmentLeaf>

	^ line spans
		findBinary: [ :aParagraphSpan |
			| originX cornerX |
			originX := aParagraphSpan baseline x.
			cornerX := originX + aParagraphSpan advance.
			(aPoint x between: originX and: cornerX )
				ifTrue: [ 0 ]
				ifFalse: [ | spanCenter |
					spanCenter := originX + ((cornerX - originX) / 2.0).
					aPoint x < spanCenter
						ifTrue: [ -1 ]
						ifFalse: [ 1 ] ] ]
		do: [ :aParagraphSpan | aFoundBlock cull: aParagraphSpan ]
		ifNone: [ :a :b | anExceptionBlock cull: (a ifNil: [ b ] ifNotNil: [ a ]) ]
]

{ #category : #accessing }
BlTextParagraph >> text [ 

	^ text
]

{ #category : #'api - instantiation' }
BlTextParagraph >> text: aBlText [
	"Construct me with a given text.
	Note, that I can be only initialized once.
	Once done, you need to measure me (build lines or words) providing an instance of Canvas as context provider.
	For that send me #measureOn: message with canvas as an argument"

	text := aBlText
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> top [
	"Return a visual top coordinate of the text (top-most rendered pixel)"

	^ line top
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> width [
	"Return measured width of the paragraph.
	Note: width may be greater than maxWidth. This may happen
	if maxWidth is smaller than width of a single line or word or character.
	We want to guarantee that at least something is displayed and measured."

	^ line width
]
