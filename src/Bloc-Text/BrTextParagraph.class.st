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
	#name : #BrTextParagraph,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'baseline',
		'maxHeight',
		'maxWidth',
		'end',
		'autoRelease',
		'text',
		'tabWidth',
		'selection',
		'containerExtent',
		'session',
		'padding'
	],
	#classInstVars : [
		'matrix'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #cleanup }
BrTextParagraph class >> cleanUp [
	super cleanUp.
	
	matrix := nil
]

{ #category : #accessing }
BrTextParagraph class >> matrix [
	"Return a temporary matrix used to collect data in.
	It is a shared singleton to minimize object creation.
	Must only be used on UI thread!"
	<return: #BlTransformation>
	
	^ matrix ifNil: [ matrix := BlTransformation new ]
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> ascent [
	"Return an ascent of the first line in a paragraph"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraph >> baseline [
	<return: #Point>

	^ (baseline computedBaseline: self) + self padding topLeft
]

{ #category : #'api - instantiation' }
BrTextParagraph >> baseline: aTextParagraphBaseline [

	baseline := aTextParagraphBaseline.
	self baselineChanged
]

{ #category : #private }
BrTextParagraph >> baselineChanged [
	"Is sent when baseline needs to be recomputed"
	self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> bottom [
	"Return a visual bottom coordinate of the text (bottom-most rendered pixel)"
	<return: #Number>

	^ self top + self height
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> bounds [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraph >> containerExtent [
	^ containerExtent
]

{ #category : #'api - instantiation' }
BrTextParagraph >> containerExtent: anObject [
	containerExtent := anObject
]

{ #category : #'instance creation' }
BrTextParagraph >> createMeasurer [
	^ self defaultMeasurer
		maxWidth: maxWidth;
		maxHeight: maxHeight;
		text: self text;
		yourself
]

{ #category : #initialization }
BrTextParagraph >> defaultMeasurer [
	^ self subclassResponsibility
]

{ #category : #initialization }
BrTextParagraph >> defaultTabWidth [
	^ 3
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> descent [
	"Return an descent of the last line in a paragraph"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'paragraph - rendering' }
BrTextParagraph >> drawOn: aCanvas [
	"Render myself on a given canvas.
	Note: I double dispatch through aCanvas to support multiple completely different canvasses"

	session == Smalltalk session
		ifFalse: [ self measureOn: aCanvas ].

	self text lockDuring: [ aCanvas drawTextParagraph: self ]
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> extent [
	"Return measured extent of the paragraph.
	@see #width and #height to learn more"
	<return: #Point>

	^ self width @ self height
]

{ #category : #finalization }
BrTextParagraph >> finalize [

	self subclassResponsibility
]

{ #category : #testing }
BrTextParagraph >> hasHeightLimit [
	"Return true if the height of the paragraph is limited, false otherwise"
	<return: #Boolean>
	
	^ self maxHeight isInfinite not
]

{ #category : #testing }
BrTextParagraph >> hasWidthLimit [
	"Return true if the width of the paragraph is limited, false otherwise"
	<return: #Boolean>
	
	^ self maxWidth isInfinite not
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> height [
	"Return measured height of the paragraph.
	Note: height may be greater than maxHeight. This may happen
	if maxHeight is smaller than height of a single line or word or character.
	We want to guarantee that at least something is displayed and measured."
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> indexAtPosition: aPoint [
	<return: #Number>
	| aParagraphSpan |

	aParagraphSpan := self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #yourself.

	^ aParagraphSpan indexAtPosition: aPoint
]

{ #category : #initialization }
BrTextParagraph >> initialize [
	super initialize.
	
	autoRelease := true.
	self reset
]

{ #category : #testing }
BrTextParagraph >> isEmpty [
	"Return true if I don't have any spans, false otherwise.
	After measurement process there must be at least one (empty) span!"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #testing }
BrTextParagraph >> isNotEmpty [
	"Return true if I have at least one (even empty) span, false otherwise.
	After measurement process there must be at least one (empty) span!"
	<return: #Boolean>

	^ self isEmpty not
]

{ #category : #testing }
BrTextParagraph >> isWhitespace: aCharacter [
	"Return true if aCharacter is a whitespace and
	therefore needs to be skipped if appears on a new line AFTER line break.
	Before sending me make sure that you don't skip characters from the start of a paragraph"
	<return: #Boolean>

	^ aCharacter = Character space
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> left [
	"Return a visual left coordinate of the text (left-most rendered pixel)"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> maxHeight [
	^ maxHeight
]

{ #category : #'api - instantiation' }
BrTextParagraph >> maxHeight: aNumber [
	maxHeight := aNumber
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> maxWidth [
	^ maxWidth
]

{ #category : #'api - instantiation' }
BrTextParagraph >> maxWidth: aNumber [
	maxWidth := aNumber
]

{ #category : #'paragraph - measuring' }
BrTextParagraph >> measureOn: aCanvas [
	"Measure myself with a given canvas as a backend-specific context.
	Note: I double dispatch through aCanvas to support multiple completely different canvasses"

	self text lockDuring: [ aCanvas measureTextParagraph: self ].

	"we should store a session of the last successfull measurement"
	session := Smalltalk session.

	self normalize: 1.
	self baselineChanged.

	self
		assert: [ self isNotEmpty ]
		description: [ 'I must not be empty after measurement!' ]
]

{ #category : #'paragraph - measuring' }
BrTextParagraph >> measureOn: aCanvas with: aSpanMeasurer [
	^ self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> measuredEnd [
	"Return a text index of the last measured character.
	Must be equal to the last character of the last span"
	<return: #Number>
	
	^ end
]

{ #category : #'paragraph - measuring' }
BrTextParagraph >> normalize: aScale [
	self subclassResponsibility
]

{ #category : #accessing }
BrTextParagraph >> padding [
	^ padding
]

{ #category : #accessing }
BrTextParagraph >> padding: aBlInsets [
	padding := aBlInsets.
	self baselineChanged
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> positionAt: anIndex [
	<return: #Point>
	| aParagraphSpan |
	
	aParagraphSpan := self spanAtIndex: anIndex.
	^ aParagraphSpan positionAt: anIndex
]

{ #category : #'paragraph - rendering' }
BrTextParagraph >> renderOn: aCanvas [ 
	self 
		deprecated: 'Use drawOn: instead'
		on: 	'18 November 2017' 
		in: 'Pharo-6.0-60520-'.
	^ self drawOn: aCanvas 
]

{ #category : #initialization }
BrTextParagraph >> reset [
	self wantsAutoRelease
		ifFalse: [ self finalize ].

	text := BlText empty.
	autoRelease := true.
	tabWidth := self defaultTabWidth.
	maxHeight := Float infinity.
	maxWidth := Float infinity.
	end := 0.
	autoRelease := true.
	selection := nil.
	containerExtent := 0@0.
	padding := BlInsets empty.
	baseline := BrTextParagraphAscentBaseline uniqueInstance
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> right [
	"Return a visual right coordinate of the text (right-most rendered pixel)"
	<return: #Number>

	^ self left + self width
]

{ #category : #'paragraph - accessing' }
BrTextParagraph >> selection [
	^ selection
]

{ #category : #'api - instantiation' }
BrTextParagraph >> selection: aBlTextSelection [
	selection := aBlTextSelection
]

{ #category : #testing }
BrTextParagraph >> skipWhitespaceIn: aString after: aStart [
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
BrTextParagraph >> spanAtIndex: anIndex [
	<return: #BrTextparagraphSpan>
	
	^ self subclassResponsibility
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> spanAtPoint: aPoint [
	<return: #BrTextparagraphSpan>
	
	^ self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #yourself
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> spanAtPoint: aPoint ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Find a paragraph span that contains a given point given in a paragraph coordinates
	and evaluate a found block if such span was found or evaluate an exception block
	with the closed span to a point"
	<return: #BrTextparagraphSpan>
	
	^ self subclassResponsibility
]

{ #category : #'paragraph - replacement' }
BrTextParagraph >> spanToString: aBrText [
	"Convert a given text span to a string replacing tabs and special character with the ones that should
	be measured and rendered"
	<return: #String>

	^ String streamContents: [ :aStream |
		aBrText do: [ :aChar |
			aChar = Character tab
				ifTrue: [ self tabWidth timesRepeat: [ aStream nextPut: Character space ] ]
				ifFalse: [ aStream nextPut: aChar ] ] ]
]

{ #category : #'paragraph - accessing' }
BrTextParagraph >> tabWidth [
	^ tabWidth
]

{ #category : #'api - instantiation' }
BrTextParagraph >> tabWidth: anObject [
	tabWidth := anObject
]

{ #category : #'paragraph - accessing' }
BrTextParagraph >> text [
	"Return the text I am assigned to"
	<return: #BlText>

	self
		assert: [ text isNotNil ]
		description: [ 'Text must never be nil' ].

	^ text
]

{ #category : #'api - instantiation' }
BrTextParagraph >> text: aBrText [
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
BrTextParagraph >> top [
	"Return a visual top coordinate of the text (top-most rendered pixel)"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #testing }
BrTextParagraph >> wantsAutoRelease [
	^ autoRelease
]

{ #category : #'paragraph - geometry' }
BrTextParagraph >> width [
	"Return measured width of the paragraph.
	Note: width may be greater than maxWidth. This may happen
	if maxWidth is smaller than width of a single line or word or character.
	We want to guarantee that at least something is displayed and measured."
	<return: #Number>

	^ self subclassResponsibility
]
