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
		'baselineMeasurer',
		'highlightsMap',
		'measuredMaxLogicalLineHeight',
		'offsetFromSegmentStart',
		'fillSize'
	],
	#classVars : [
		'DefaultText'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'class initialization' }
BlTextElement class >> initialize [ 
	DefaultText := 'Text' asRopedText readonly
]

{ #category : #'instance creation' }
BlTextElement class >> text: aBlText [

	^ self new
		  text: aBlText;
		  yourself
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

{ #category : #'api - highlighting' }
BlTextElement >> defaultHighlightCategory [

	^ #default
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

{ #category : #'selection - management' }
BlTextElement >> hasSelection [
	^ self selection isNotEmpty
]

{ #category : #'api - highlighting' }
BlTextElement >> highlightCategory: aHighlightCategorySymbol with: aParagraphHighlight [ 

	| l |
	l := self highlightsMap at: aHighlightCategorySymbol ifAbsentPut: [OrderedCollection new].
	l add: aParagraphHighlight.
	self invalidate
]

{ #category : #'api - highlighting' }
BlTextElement >> highlightWith: aParagraphHighlight [ 

	self highlightCategory: self defaultHighlightCategory with: aParagraphHighlight. 

]

{ #category : #'api - highlighting' }
BlTextElement >> highlights [

	^ highlightsMap ifNotNil: [ :map | 
		  Array streamContents: [ :stream | map valuesDo: [ :v | stream nextPutAll: v ] ] ]
]

{ #category : #'api - highlighting' }
BlTextElement >> highlightsMap [

	^ highlightsMap ifNil: [ highlightsMap := IdentityDictionary new ]
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
	measurer := self defaultMeasurer.

	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	selection := BlCompositeSelection new.

	"self debug: true"
]

{ #category : #layout }
BlTextElement >> isTabulation [ 
	^ text isNotEmpty and: [ text first = Character tab ]
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
BlTextElement >> measuredMaxLogicalLineHeight [
	"computed and set during layout"
	^ measuredMaxLogicalLineHeight
]

{ #category : #layout }
BlTextElement >> measuredMaxLogicalLineHeight: aNumber [
	"computed and set during layout"
	measuredMaxLogicalLineHeight := aNumber
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

{ #category : #layout }
BlTextElement >> offsetFromSegmentStart [
	"computed and set during layout"
	^ offsetFromSegmentStart
]

{ #category : #layout }
BlTextElement >> offsetFromSegmentStart: aNumber [
	"computed and set during layout"
	offsetFromSegmentStart := aNumber
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
	fillSize := nil.
	self onParagraphMeasure: anExtentMeasurementSpec.
	self measureChildren: anExtentMeasurementSpec
]

{ #category : #layout }
BlTextElement >> onParagraphMeasure: anExtentMeasurementSpec [

	"If I am executed it means that measurement specification changed.
	We have to recreate a text layout with new parameters"

	| aMaxWidth aMaxHeight aWidthSpec aHeightSpec aPadding aMeasuredWidth aMeasuredHeight aMeasuredExtent aMeasuredBounds |
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	aPadding := self constraints padding.

	aMaxWidth := self computeMaxWidth: anExtentMeasurementSpec.
	aMaxHeight := self computeMaxHeight: anExtentMeasurementSpec.

	paragraph := self createTextParagraph.

	"Create a new text layout"
	paragraph
		text: self text;
		baselineMeasurer: self baselineMeasurer;
		maxWidth: aMaxWidth;
		maxHeight: aMaxHeight;
		scale: self globalScale.

	self basicMeasureParagraph: paragraph.
	self onTabulationMeasure: anExtentMeasurementSpec.

	"text layout is measured at this point"
	aMeasuredBounds := measurement boundsOf: paragraph.
	aMeasuredWidth := aMeasuredBounds width min: aMaxWidth.
	aMeasuredHeight := aMeasuredBounds height min: aMaxHeight.

	"If measurement spec is exact I must ignore size measured by textLayout"
	aWidthSpec isExact ifTrue: [ aMeasuredWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ aMeasuredHeight := aHeightSpec size ].

	"Take minimal width and height into account"
	aMeasuredWidth := aMeasuredWidth max: self constraints minWidth - aPadding width.
	aMeasuredHeight := aMeasuredHeight max: self constraints minHeight - aPadding height.
	aMeasuredExtent := aMeasuredWidth @ aMeasuredHeight.
	"Take padding into account"
	aMeasuredExtent := aMeasuredExtent + (aPadding width @ aPadding height).

	"Finally set measured extent"
	self measuredExtent: aMeasuredExtent
]

{ #category : #'hooks - session' }
BlTextElement >> onSessionChanged: aNewSession [
	super onSessionChanged: aNewSession.
	
	self textChanged
]

{ #category : #layout }
BlTextElement >> onTabulationMeasure: anExtentMeasurementSpec [
	" nothing to do here, done on AlbTextElement for now"
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

{ #category : #'private - pool' }
BlTextElement >> recycledFrom: aStencilBuilder [

	self removeFromParent.
	self selectNone
]

{ #category : #'private - paragraph' }
BlTextElement >> releaseParagraph [
	paragraph := nil
]

{ #category : #'api - font size' }
BlTextElement >> resetDefaultFontSize [
	defaultFontSize := nil
]

{ #category : #'api - highlighting' }
BlTextElement >> resetHighlightsMap [

	highlightsMap := nil.
	self invalidate
]

{ #category : #'api - highlighting' }
BlTextElement >> resetHighlightsOfCategory: aHighlightCategorySymbol [

	highlightsMap ifNil: [ ^self ].
	highlightsMap removeKey: aHighlightCategorySymbol ifAbsent: [^self].
	self invalidate
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

{ #category : #'private - paragraph' }
BlTextElement >> setupParagraphBeforeDrawing [

	"Push all which are needed for drawing "

	"fillSize is for tabulation at end of line. see #onParagraphMeasure: "
	paragraph containerExtent: (fillSize
			 ifNil: [ self extent ]
			 ifNotNil: [ (fillSize max: self extent x) @ self extent y ]).
	paragraph selection: self selection.
	paragraph padding: self padding.
	" highligh is lazy, do not use the accessor"
	paragraph highlights: self highlights
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
	"Change a text I represent"
	text = aBlText ifTrue: [ ^ self ].
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

	self measurement: BlTextElementTightMeasurementStrategy uniqueInstance.
	self baselineMeasurer: BlBoundsBaselineMeasurer uniqueInstance
]
