"
I represent a simple singleline text element without support of scrolling.

I can measure and render provided immutable styled text; an instance of SpText.
I am the best choice if you want to display small pieces of text.

Public API and Key Messages

- text: to change text I should represent

Example:

   textElement := BlTextElement new.
   textElement text: (SpText fromString: 'Hello world!').
 
Internal Representation and Key Implementation Points.

    Instance Variables
	textLayout:		<SpTextLayout> a measured and splitted text layout. Recreated on each measurement step. Used to render text.
	text:			<SpText> a text I represent


    Implementation Points

Since text measurement is backend specific I use an offscreen canvas to measure text.
See #defaultOffscreenCanvas
"
Class {
	#name : #BlTextElement,
	#superclass : #BlElement,
	#instVars : [
		'text',
		'paragraph',
		'selection',
		'baseline'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'instance creation' }
BlTextElement class >> text: aBrText [
	^ self new text: aBrText
]

{ #category : #'api - text' }
BlTextElement >> ascentBaseline [
	self baseline: BrTextParagraphAscentBaseline uniqueInstance
]

{ #category : #accessing }
BlTextElement >> baseline [
	
	^ baseline
]

{ #category : #accessing }
BlTextElement >> baseline: aTextParagraphBaseline [
	baseline := aTextParagraphBaseline.
	self textChanged
]

{ #category : #'api - text' }
BlTextElement >> boundsBaseline [
	self baseline: BrTextParagraphBoundsBaseline uniqueInstance
]

{ #category : #initialization }
BlTextElement >> defaultBaseline [
	<return: #BrTextParagraphBaseline>

	^ BrTextParagraphAscentBaseline uniqueInstance
]

{ #category : #initialization }
BlTextElement >> defaultText [
	"Return a default text I should be created with"
	<return: #BlText>

	^ BlRopedText string: 'Text'
]

{ #category : #initialization }
BlTextElement >> defaultTextMeasurer [
	"Return an offscreen canvas used to measure text.
	It must be of the same type and backend as rendering canvas"
	<return: #SpartaCanvas>

	^ Bloc preferableSpartaCanvas offscreen
]

{ #category : #initialization }
BlTextElement >> defaultTextParagraph [
	"Create a text paragraph used to measure and render text"
	<return: #BrTextParagraph>

	^ BrSingleLineTextParagraph new
]

{ #category : #'selection - management' }
BlTextElement >> deselect: aFromIndex to: aToIndex [

	self selection
		deselect: aFromIndex
		to: aToIndex.

	self invalidate
]

{ #category : #initialization }
BlTextElement >> initialize [
	super initialize.
	
	text := self defaultText.
	baseline := self defaultBaseline.
	"Text layout is created during measurement in onMeasure:"
	paragraph := nil.
	
	"self border: (BlBorder paint: Color random width: 1) .
	self background: Color yellow muchLighter muchLighter."
	
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	selection := BlCompositeSelection new
]

{ #category : #layout }
BlTextElement >> measureChildren: anExtentMeasurementSpec [	
	self layout measuredChildren: self do: [ :aChild |
		| aWidthResizer aHeightResizer aWidthSpec aHeightSpec  |
		
		aWidthResizer := aChild constraints horizontal resizer.
		aHeightResizer := aChild constraints vertical resizer.
		
		aWidthResizer isMatchParent
			ifTrue: [ aWidthSpec := BlMeasurementSpec exact: self measuredWidth ]
			ifFalse: [ aWidthSpec := self layout
				measurementSpecFor: anExtentMeasurementSpec widthSpec
				usedSize: 0
				resizer: aWidthResizer ].
			
		aHeightResizer isMatchParent
			ifTrue: [ aHeightSpec := BlMeasurementSpec exact: self measuredHeight ]
			ifFalse: [ aHeightSpec := self layout
				measurementSpecFor: anExtentMeasurementSpec heightSpec
				usedSize: 0
				resizer: aHeightResizer ].
	
		aChild measure: aWidthSpec @ aHeightSpec ]
]

{ #category : #layout }
BlTextElement >> onMeasure: anExtentMeasurementSpec [
	"If I am executed it means that measurement specification changed.
	We have to recreate a text layout with new parameters"
	| aHeightSpec aWidthSpec aMaxHeight aMaxWidth aPadding aMeasuredWidth aMeasuredHeight aMeasuredExtent |

	self
		assert: [ text isNotNil ]
		description: [ 'Text model must be nil!' ].

	(self shouldMeasure: anExtentMeasurementSpec)
		ifFalse: [ ^ self ].

	aMaxWidth := self constraints maxWidth.
	aMaxHeight := self constraints maxHeight.
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	aPadding := self constraints padding.
	
	"Unspecified means that layout may take as much space horizontally as it wishes"
	aWidthSpec isUnspecified
		ifFalse: [ aMaxWidth := aMaxWidth min: aWidthSpec size ].
		"Unspecified means that layout may take as much space horizontally as it wishes"
	aHeightSpec isUnspecified
		ifFalse: [ aMaxHeight := aMaxHeight min: aHeightSpec size ].
	
	"Exact spec limits max height and width to specific values"
	aWidthSpec isExact ifTrue: [ 
		aMaxWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ 
		aMaxHeight := aHeightSpec size ].

	aMaxWidth := (aMaxWidth - aPadding width) max: 0.
	aMaxHeight := (aMaxHeight - aPadding height) max: 0.

	paragraph
		"Create a new text layout"
		ifNil: [ paragraph := self defaultTextParagraph ]
		"or reuse existing"
		ifNotNil: [ paragraph reset ].

	paragraph
		baseline: self baseline;
		text: self text;
		maxWidth: aMaxWidth;
		maxHeight: aMaxHeight;
		padding: self padding.

	paragraph measureOn: self defaultTextMeasurer.
	"text layout is measured at this point"

	aMeasuredWidth := paragraph width.
	aMeasuredHeight := (paragraph ascent + paragraph descent).

	"If measurement spec is exact I must ignore size measured by textLayout"
	aWidthSpec isExact ifTrue: [ 
		aMeasuredWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ 
		aMeasuredHeight := aHeightSpec size ].

	"Take minimal width and height into account"
	aMeasuredWidth := aMeasuredWidth max: self constraints minWidth - aPadding width.
	aMeasuredHeight := aMeasuredHeight max: self constraints minHeight - aPadding height.
	aMeasuredExtent := aMeasuredWidth @ aMeasuredHeight.
	"Take padding into account"
	aMeasuredExtent := aMeasuredExtent + (aPadding width @ aPadding height).

	"Finally set measured extent"
	self measuredExtent: aMeasuredExtent.
	
	"don't forget to measure children if there are any"
	self measureChildren: anExtentMeasurementSpec
]

{ #category : #'children hooks' }
BlTextElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	paragraph
		ifNil: [ ^ self ].

	paragraph wantsAutoRelease
		ifFalse: [ paragraph finalize ]
]

{ #category : #accessing }
BlTextElement >> paragraph [
	^ paragraph
]

{ #category : #'selection - management' }
BlTextElement >> select: aFromIndex to: aToIndex [

	self selection
		select: aFromIndex
		to: aToIndex.

	self invalidate
]

{ #category : #'selection - management' }
BlTextElement >> selectNone [
	self selection removeAll.
	self invalidate
]

{ #category : #'selection - management' }
BlTextElement >> selectSet: aFromIndex to: aToIndex [

	self selection
		removeAll;
		select: aFromIndex
		to: aToIndex.

	self invalidate
]

{ #category : #'selection - management' }
BlTextElement >> selection [
	<return: #BlSelection>
	
	self
		assert: [ selection isNotNil ]
		description: [ 'Selection can not be nil' ].

	^ selection
]

{ #category : #layout }
BlTextElement >> shouldMeasure: anExtentMeasurementSpec [
	| aHeightSpec aWidthSpec isWidthValid isHeightValid |

	"If we don't have text layout we must re-measure"
	paragraph
		ifNil: [ ^ true ].

	self isLayoutRequested
		ifTrue: [ ^ true ].

	true ifTrue: [ ^ true ].

	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.

	"If any spec is exact we must re-measure. Exact limit available height and width"
	(aWidthSpec isExact or: [ aHeightSpec isExact ])
		ifTrue: [ ^ true ].

	isWidthValid := aWidthSpec isUnspecified or: [ 
		"at most size"
		aWidthSpec size >= paragraph width ].
	
	isHeightValid := aHeightSpec isUnspecified or: [ 
		"at most size"
		aHeightSpec size >= paragraph height ].
	
	^ (isWidthValid and: [ isHeightValid ]) not
]

{ #category : #accessing }
BlTextElement >> text [
	"Return the text I currently represent.
	Note, that I work with immutable text (BrText), so if you want to change or style text
	you have to set manually sending #text: message with new styled text model"
	<return: #BlText>
	
	^ text
]

{ #category : #accessing }
BlTextElement >> text: aTextModel [
	"Change a text I represent.
	Note, that aTextModel should be an instance of BrText.
	aTextModel must not be nil"

	self
		assert: [ aTextModel isNotNil ]
		description: [ 'A text model must not be nil' ].
		
	self
		assert: [ aTextModel isKindOf: BlText ]
		description: [ 'A text model must be an instance if Text' ].

	text := aTextModel.
	self textChanged
]

{ #category : #'change reporting' }
BlTextElement >> textChanged [
	"text layout is no more valid, remove it"
	paragraph := nil.

	"request redraw and layout"
	self requestLayout.
	self invalidate
]

{ #category : #accessing }
BlTextElement >> textDo: aBlock [
	"Perform a given block with my current text model as an argument and invalidate text"
	aBlock value: self text.
	self textChanged
]
