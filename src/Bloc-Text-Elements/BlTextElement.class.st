"
# Text element

**I am independent from Sparta **

I support multiple measurement strategies, see examples for more detailed explanation:
{{gtClass:BlTextElementMeasurementStrategyExamples}}


"
Class {
	#name : #BlTextElement,
	#superclass : #BlElement,
	#instVars : [
		'text',
		'paragraph',
		'selection',
		'measurement',
		'measurer',
		'defaultFontSize',
		'baselineMeasurer'
	],
	#classVars : [
		'DefaultText',
		'ParagraphPool'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'class initialization' }
BlTextElement class >> cleanUp [
	self initialize
]

{ #category : #'class initialization' }
BlTextElement class >> initialize [
	ParagraphPool := BlSynchronizedObjectPool pool: (BlBagObjectPool new: 1000).
	DefaultText := 'Text' asRopedText readonly
]

{ #category : #'instance creation' }
BlTextElement class >> text: aBlText [

	^ self new
		  text: aBlText;
		  yourself
]

{ #category : #'private - paragraph' }
BlTextElement >> acquireParagraph [
	| aParagraph |
	
	aParagraph := ParagraphPool acquire
		ifNil: [ self createTextParagraph ].
	aParagraph reset.

	^ aParagraph
]

{ #category : #accessing }
BlTextElement >> baseline [

	self
		deprecated: 'Please use baselineMeasurer instead.'
		transformWith:
			'`@receiver baseline'
				-> '`@receiver baselineMeasurer'.
	
	^ self baselineMeasurer
]

{ #category : #accessing }
BlTextElement >> baseline: aBlTextParagraphBaselineMeasurer [

	self
		deprecated: 'Please use baselineMeasurer: instead.'
		transformWith:
			'`@receiver baseline: `@statements1'
				-> '`@receiver baselineMeasurer: `@statements1'.

	self baselineMeasurer: aBlTextParagraphBaselineMeasurer.

]

{ #category : #accessing }
BlTextElement >> baselineMeasurer [
	
	^ baselineMeasurer
]

{ #category : #accessing }
BlTextElement >> baselineMeasurer: aBlTextParagraphBaselineMeasurer [

	baselineMeasurer := aBlTextParagraphBaselineMeasurer.
	self textChanged
]

{ #category : #layout }
BlTextElement >> baselineOffset [
	^ paragraph
		ifNotNil: [ paragraph baseline y + self padding top ]
		ifNil: [ 0 ]
]

{ #category : #layout }
BlTextElement >> basicMeasureParagraph: aBlTextParagraph [
	measurer measureTextParagraph: aBlTextParagraph of: self
]

{ #category : #layout }
BlTextElement >> computeMaxHeight: anExtentMeasurementSpec [
	<return: #Number>
	| aMaxHeight aHeightSpec aPadding |

	aMaxHeight := self constraints maxHeight.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	aPadding := self constraints padding.
	
	aHeightSpec isUnspecified
		ifFalse: [ aMaxHeight := aMaxHeight min: aHeightSpec size ].

	aMaxHeight := (aMaxHeight - aPadding height) max: 0.
	
	^ aMaxHeight
]

{ #category : #layout }
BlTextElement >> computeMaxWidth: anExtentMeasurementSpec [
	<return: #Number>
	| aMaxWidth aWidthSpec aPadding |

	aMaxWidth := self constraints maxWidth.
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aPadding := self constraints padding.
	
	"Unspecified means that layout may take as much space horizontally as it wishes"
	aWidthSpec isUnspecified
		ifFalse: [ aMaxWidth := aMaxWidth min: aWidthSpec size ].

	aMaxWidth := (aMaxWidth - aPadding width) max: 0.
	
	^ aMaxWidth
]

{ #category : #'private - paragraph' }
BlTextElement >> createTextParagraph [
	"Create a text paragraph used to measure and render text"

	^ BlTextParagraph new
]

{ #category : #'api - font size' }
BlTextElement >> defaultFontSize: aNumber [	
	defaultFontSize = aNumber
		ifTrue: [ ^ self ].

	defaultFontSize := aNumber.
	
	self text defaultFontSize: aNumber.
	self textChanged
]

{ #category : #initialization }
BlTextElement >> defaultMeasurer [
	^ BlTextElementHostMeasurer new
]

{ #category : #initialization }
BlTextElement >> defaultText [
	"Return a default text I should be created with"
	<return: #BlText>

	^ DefaultText
]

{ #category : #'selection - management' }
BlTextElement >> deselect: aFromIndex to: aToIndex [

	self selection
		deselect: aFromIndex
		to: aToIndex.

	self invalidate
]

{ #category : #'api - text' }
BlTextElement >> editorMeasurement [

	self measurement:
		BlTextElementEditorMeasurementStrategy uniqueInstance.
	self baselineMeasurer: BlAscentLooseBaselineMeasurer uniqueInstance
]

{ #category : #geometry }
BlTextElement >> indexAtScreenPosition: aPoint [
	<return: #Number>

	^ self paragraph indexAtPosition: aPoint - self padding topLeft
]

{ #category : #initialization }
BlTextElement >> initialize [
	super initialize.

	self tightMeasurement.

	text := self defaultText.
	"Text layout is created during measurement in onMeasure:"
	paragraph := nil.
	measurer := self defaultMeasurer.

	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	selection := BlCompositeSelection new.

	"self debug: true"
]

{ #category : #'api - text' }
BlTextElement >> labelMeasurement [

	self measurement:
		BlTextElementLabelMeasurementStrategy uniqueInstance.
	self baselineMeasurer: BlAscentTightBaselineMeasurer uniqueInstance
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
				usedSize: 0.0
				resizer: aWidthResizer ].

		aHeightResizer isMatchParent
			ifTrue: [ aHeightSpec := BlMeasurementSpec exact: self measuredHeight ]
			ifFalse: [ aHeightSpec := self layout
				measurementSpecFor: anExtentMeasurementSpec heightSpec
				usedSize: 0.0
				resizer: aHeightResizer ].
	
		aChild measure: aWidthSpec @ aHeightSpec ].
	
	self layout measureIgnored: self with: anExtentMeasurementSpec
]

{ #category : #layout }
BlTextElement >> measureParagraph: anExtentMeasurementSpec [

	"If I am executed it means that measurement specification changed.
	We have to recreate a text layout with new parameters"

	| aMaxWidth aMaxHeight aWidthSpec aHeightSpec aPadding aMeasuredWidth aMeasuredHeight aMeasuredExtent aMeasuredBounds |
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	aPadding := self constraints padding.

	aMaxWidth := self computeMaxWidth: anExtentMeasurementSpec.
	aMaxHeight := self computeMaxHeight: anExtentMeasurementSpec.

	paragraph
		ifNil: [ "or reuse existing" paragraph := self acquireParagraph ]
		ifNotNil: [ paragraph reset ].
	"Create a new text layout"

	paragraph
		baselineMeasurer: self baselineMeasurer;
		text: self text;
		maxWidth: aMaxWidth;
		maxHeight: aMaxHeight;
		scale: self globalScale.

	self telemetry
		timeSync: [ 'Paragraph measureOn: ' , self class name ]
		during: [ self basicMeasureParagraph: paragraph ].

	"text layout is measured at this point"
	aMeasuredBounds := measurement boundsOf: paragraph.
	aMeasuredWidth := aMeasuredBounds width min: aMaxWidth.
	aMeasuredHeight := aMeasuredBounds height min: aMaxHeight.

	"If measurement spec is exact I must ignore size measured by textLayout"
	aWidthSpec isExact ifTrue: [ aMeasuredWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ aMeasuredHeight := aHeightSpec size ].

	"Take minimal width and height into account"
	aMeasuredWidth := aMeasuredWidth max:
		                  self constraints minWidth - aPadding width.
	aMeasuredHeight := aMeasuredHeight max:
		                   self constraints minHeight - aPadding height.
	aMeasuredExtent := aMeasuredWidth @ aMeasuredHeight.
	"Take padding into account"
	aMeasuredExtent := aMeasuredExtent
	                   + (aPadding width @ aPadding height).

	"Finally set measured extent"
	self measuredExtent: aMeasuredExtent
]

{ #category : #accessing }
BlTextElement >> measurement [
	<return: #BlTextElementMeasurementStrategy>

	^ measurement
]

{ #category : #accessing }
BlTextElement >> measurement: aTextElementMeasurementStrategy [
	measurement := aTextElementMeasurementStrategy.
	self textChanged
]

{ #category : #accessing }
BlTextElement >> measurer [
	^ measurer
]

{ #category : #accessing }
BlTextElement >> measurer: anObject [
	measurer := anObject.
	self textChanged
]

{ #category : #'hooks - session' }
BlTextElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	paragraph
		ifNil: [ ^ self ].
		
	paragraph session == Smalltalk session
		ifFalse: [ self textChanged ]
]

{ #category : #layout }
BlTextElement >> onMeasure: anExtentMeasurementSpec [

	text ifNil: [ self error: 'Text model must not be nil!' ].

	(self shouldMeasure: anExtentMeasurementSpec)
		ifTrue: [ 
			self telemetry
				timeSync: [ 'Measure paragraph: ', self class name ]
				during: [ self measureParagraph: anExtentMeasurementSpec ] ].
	
	self telemetry
		timeSync: [ 'Measure children: ', self class name ]
		during: [ self measureChildren: anExtentMeasurementSpec ]
]

{ #category : #'hooks - session' }
BlTextElement >> onSessionChanged: aNewSession [
	super onSessionChanged: aNewSession.
	
	self textChanged
]

{ #category : #'private - paragraph' }
BlTextElement >> paragraph [

	^ paragraph
]

{ #category : #accessing }
BlTextElement >> rawParagraph [

	self
		deprecated: 'Please use paragraph instead.'
		transformWith:
			'`@receiver rawParagraph'
				-> '`@receiver paragraph'.
	
	^ self paragraph
]

{ #category : #'private - paragraph' }
BlTextElement >> releaseParagraph [
	| aParagraph |
	
	paragraph
		ifNil: [ ^ self ].

	aParagraph := paragraph.

	aParagraph reset.
	ParagraphPool release: aParagraph.
	
	paragraph := nil
]

{ #category : #'api - font size' }
BlTextElement >> resetDefaultFontSize [
	defaultFontSize := nil
]

{ #category : #geometry }
BlTextElement >> screenPositionAt: aTextIndex [
	<return: #Point>
	| aScreenPosition |
	
	aScreenPosition := self paragraph positionAt: aTextIndex.
	^ (aScreenPosition x + self padding left) @ ((self height + self padding height) / 2.0)
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
	self selection isEmpty
		ifTrue: [ ^ self ].
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

	paragraph
		ifNil: [ ^ true ].
		
	paragraph isEmpty
		ifTrue: [ ^ true ].

	(self privatePreviousMeasurementSpec = anExtentMeasurementSpec)
		ifFalse: [ ^ true ].

	paragraph maxWidth = (self computeMaxWidth: anExtentMeasurementSpec)
		ifFalse: [ ^ true ].

	paragraph maxHeight = (self computeMaxHeight: anExtentMeasurementSpec)
		ifFalse: [ ^ true ].

	^ false
]

{ #category : #layout }
BlTextElement >> supportsBaseline [
	<return: #Boolean>

	^ true
]

{ #category : #accessing }
BlTextElement >> text [
	"Return the text I currently represent.
	Note, that I work with immutable text (BlText), so if you want to change or style text
	you have to set manually sending #text: message with new styled text model"
	
	^ text
]

{ #category : #accessing }
BlTextElement >> text: aBlText [
	"Change a text I represent.
	Note, that aTextModel should be an instance of BrText.
	aTextModel must not be nil"

	text = aBlText
		ifTrue: [ ^ self ].

	text := aBlText.
	defaultFontSize ifNotNil: [ :aDefaultFontSize | text defaultFontSize: aDefaultFontSize ].
	self textChanged
]

{ #category : #'change reporting' }
BlTextElement >> textChanged [
	"text layout is no more valid, remove it"
	self releaseParagraph.

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

{ #category : #'api - text' }
BlTextElement >> tightMeasurement [

	self measurement:
		BlTextElementTightMeasurementStrategy uniqueInstance.
	self baselineMeasurer: BlBoundsBaselineMeasurer uniqueInstance
]
