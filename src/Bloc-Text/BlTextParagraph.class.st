"
I am an abstract text paragraph. My main role is to measure text according to given additional properties or constraints and prepare it for rendering.

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
	text:		<BrText>
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
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'baseline',
		'maxHeight',
		'maxWidth',
		'end',
		'text',
		'tabWidth',
		'containerExtent',
		'session',
		'scale',
		'selection',
		'highlights'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'paragraph - geometry' }
BlTextParagraph >> ascent [
	"Return an ascent of the first line in a paragraph"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraph >> baseline [
	<return: #Point>

	^ baseline computedBaseline: self
]

{ #category : #'api - instantiation' }
BlTextParagraph >> baseline: aTextParagraphBaseline [

	baseline := aTextParagraphBaseline.
	self baselineChanged
]

{ #category : #private }
BlTextParagraph >> baselineChanged [
	"Is sent when baseline needs to be recomputed"
	self subclassResponsibility
]

{ #category : #'paragraph - measuring' }
BlTextParagraph >> basicMeasureOn: aBlHostTextMeasurer [
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> bottom [
	"Return a visual bottom coordinate of the text (bottom-most rendered pixel)"
	<return: #Number>

	^ self top + self height
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> bounds [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraph >> containerExtent [
	^ containerExtent
]

{ #category : #'api - instantiation' }
BlTextParagraph >> containerExtent: anObject [
	containerExtent := anObject
]

{ #category : #'instance creation' }
BlTextParagraph >> createMeasurer [
	^ self defaultMeasurer
		maxWidth: maxWidth;
		maxHeight: maxHeight;
		yourself
]

{ #category : #initialization }
BlTextParagraph >> defaultMeasurer [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlTextParagraph >> defaultTabWidth [
	^ 3
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> descent [
	"Return an descent of the last line in a paragraph"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'paragraph - rendering' }
BlTextParagraph >> drawOn: aCanvas [
	"Render myself on a given canvas.
	Note: I double dispatch through aCanvas to support multiple completely different canvasses"

	session == Smalltalk session
		ifFalse: [ ^ self ].

	aCanvas drawTextParagraph: self
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> extent [
	"Return measured extent of the paragraph.
	@see #width and #height to learn more"
	<return: #Point>

	^ self width @ self height
]

{ #category : #finalization }
BlTextParagraph >> finalize [

	self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraph >> gtTextFor: aView [
	<gtView>
	self text isNil ifTrue: [ ^ aView empty ].
	^ self text gtTextFor: aView
]

{ #category : #testing }
BlTextParagraph >> hasHeightLimit [
	"Return true if the height of the paragraph is limited, false otherwise"
	<return: #Boolean>
	
	^ self maxHeight isInfinite not
]

{ #category : #testing }
BlTextParagraph >> hasWidthLimit [
	"Return true if the width of the paragraph is limited, false otherwise"
	<return: #Boolean>
	
	^ self maxWidth isInfinite not
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> height [
	"Return measured height of the paragraph.
	Note: height may be greater than maxHeight. This may happen
	if maxHeight is smaller than height of a single line or word or character.
	We want to guarantee that at least something is displayed and measured."
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - highlighting' }
BlTextParagraph >> highlight: aHighlightAttribute from: aFromIndex to: aToIndex [
	highlights
		ifNil: [ highlights := IdentityDictionary new ].

	(highlights
		at: aHighlightAttribute
		ifAbsentPut: [ BlTextParagraphHighlight new ])
			highlight: aHighlightAttribute paint
			from: ((aFromIndex - 1) max: 0)
			to: aToIndex
]

{ #category : #'api - instantiation' }
BlTextParagraph >> highlights [
	<return: #Collection of: #BlTextParagraphHighlight>

	^ highlights
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> indexAtPosition: aPoint [
	<return: #Number>
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

	self reset
]

{ #category : #testing }
BlTextParagraph >> isEmpty [
	"Return true if I don't have any spans, false otherwise.
	After measurement process there must be at least one (empty) span!"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #testing }
BlTextParagraph >> isNotEmpty [
	"Return true if I have at least one (even empty) span, false otherwise.
	After measurement process there must be at least one (empty) span!"
	<return: #Boolean>

	^ self isEmpty not
]

{ #category : #testing }
BlTextParagraph >> isWhitespace: aCharacter [
	"Return true if aCharacter is a whitespace and
	therefore needs to be skipped if appears on a new line AFTER line break.
	Before sending me make sure that you don't skip characters from the start of a paragraph"
	<return: #Boolean>

	^ aCharacter = Character space
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> left [
	"Return a visual left coordinate of the text (left-most rendered pixel)"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> maxHeight [
	^ maxHeight
]

{ #category : #'api - instantiation' }
BlTextParagraph >> maxHeight: aNumber [
	maxHeight := aNumber
]

{ #category : #'paragraph - geometry' }
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

	"we should store a session of the last successfull measurement"
	session := Smalltalk session.

	"self normalize: self scale."
	self baselineChanged.

	self
		assert: [ self isNotEmpty ]
		description: [ 'I must not be empty after measurement!' ]
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> measuredEnd [
	"Return a text index of the last measured character.
	Must be equal to the last character of the last span"
	<return: #Number>
	
	^ end
]

{ #category : #'paragraph - measuring' }
BlTextParagraph >> normalize: aScale [
	self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> positionAt: anIndex [
	<return: #Point>
	| aParagraphSpan |

	aParagraphSpan := self spanAtIndex: anIndex.
	^ aParagraphSpan positionAt: anIndex
]

{ #category : #'paragraph - rendering' }
BlTextParagraph >> renderOn: aCanvas [ 
	self 
		deprecated: 'Use drawOn: instead'
		on: 	'18 November 2017' 
		in: 'Pharo-6.0-60520-'.
	^ self drawOn: aCanvas 
]

{ #category : #initialization }
BlTextParagraph >> reset [
	self finalize.

	text := BlText empty.
	tabWidth := self defaultTabWidth.
	maxHeight := Float infinity.
	maxWidth := Float infinity.
	session := nil.
	end := 0.
	selection := nil.
	highlights := nil.
	containerExtent := 0@0.
	baseline := BlTextParagraphAscentLooseBaseline uniqueInstance.
	scale := 1
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> right [
	"Return a visual right coordinate of the text (right-most rendered pixel)"
	<return: #Number>

	^ self left + self width
]

{ #category : #accessing }
BlTextParagraph >> scale [
	<return: #Number>

	^ scale
]

{ #category : #accessing }
BlTextParagraph >> scale: aNumber [
	scale := aNumber
]

{ #category : #'paragraph - accessing' }
BlTextParagraph >> selection [
	^ selection
]

{ #category : #'api - instantiation' }
BlTextParagraph >> selection: aBlTextSelection [
	selection := aBlTextSelection
]

{ #category : #accessing }
BlTextParagraph >> session [
	^ session
]

{ #category : #testing }
BlTextParagraph >> skipWhitespaceIn: aString after: aStart [
	"Return an index of the first non-whitespace character in aString after aStart index"
	<return: #Number>
	| anIndex aChar |

	anIndex := aStart.
	aChar := aString at: anIndex.
	[ anIndex < aString size
		and: [ self isWhitespace: aChar ] ]
			whileTrue: [ 
				anIndex := anIndex + 1.
				aChar := aString at: anIndex ].
	^ anIndex
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> spanAtIndex: anIndex [
	<return: #BlTextParagraphSpan>
	
	^ self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> spanAtPoint: aPoint [
	<return: #BlTextParagraphSpan>
	
	^ self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #yourself
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> spanAtPoint: aPoint ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Find a paragraph span that contains a given point given in a paragraph coordinates
	and evaluate a found block if such span was found or evaluate an exception block
	with the closed span to a point"
	<return: #BlTextParagraphSpan>
	
	^ self subclassResponsibility
]

{ #category : #'paragraph - accessing' }
BlTextParagraph >> tabWidth [
	^ tabWidth
]

{ #category : #'api - instantiation' }
BlTextParagraph >> tabWidth: anObject [
	tabWidth := anObject
]

{ #category : #'paragraph - accessing' }
BlTextParagraph >> text [
	"Return the text I am assigned to"
	<return: #BlText>

	self
		assert: [ text isNotNil ]
		description: [ 'Text must never be nil' ].

	^ text
]

{ #category : #'api - instantiation' }
BlTextParagraph >> text: aBrText [
	"Construct me with a given text.
	Note, that I can be only initialized once.
	Once done, you need to measure me (build lines or words) providing an instance of Canvas as context provider.
	For that send me #measureOn: message with canvas as an argument"

	self
		assert: [ text = BlText empty ]
		description: [ 'I am immutable! You should create a new instance or #reset me' ].

	text := aBrText
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> top [
	"Return a visual top coordinate of the text (top-most rendered pixel)"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #testing }
BlTextParagraph >> wantsAutoRelease [
	^ true
]

{ #category : #'paragraph - geometry' }
BlTextParagraph >> width [
	"Return measured width of the paragraph.
	Note: width may be greater than maxWidth. This may happen
	if maxWidth is smaller than width of a single line or word or character.
	We want to guarantee that at least something is displayed and measured."
	<return: #Number>

	^ self subclassResponsibility
]
