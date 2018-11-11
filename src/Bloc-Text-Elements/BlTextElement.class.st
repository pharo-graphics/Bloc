"
! Text element

""""I am independent from Sparta """"

${class:BlTextElementBaselineExamples}$
"
Class {
	#name : #BlTextElement,
	#superclass : #BlElement,
	#instVars : [
		'text',
		'paragraph',
		'selection',
		'baseline',
		'measurer',
		'measurement'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'instance creation' }
BlTextElement class >> text: aBrText [
	^ self new text: aBrText
]

{ #category : #'api - text' }
BlTextElement >> ascentBaseline [
	self baseline: BlTextParagraphAscentBaseline uniqueInstance
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

{ #category : #layout }
BlTextElement >> baselineOffset [
	^ paragraph
		ifNotNil: [ paragraph baseline y ]
		ifNil: [ 0 ].
]

{ #category : #'api - text' }
BlTextElement >> boundsBaseline [
	self baseline: BlTextParagraphBoundsBaseline uniqueInstance
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

{ #category : #initialization }
BlTextElement >> defaultText [
	"Return a default text I should be created with"
	<return: #BlText>

	^ BlRopedText string: 'Text'
]

{ #category : #initialization }
BlTextElement >> defaultTextMeasurer [
	^ BlTextElementCanvasMeasurer new
]

{ #category : #initialization }
BlTextElement >> defaultTextParagraph [
	"Create a text paragraph used to measure and render text"
	<return: #BlTextParagraph>

	^ BlSingleLineTextParagraph new
]

{ #category : #'selection - management' }
BlTextElement >> deselect: aFromIndex to: aToIndex [

	self selection
		deselect: aFromIndex
		to: aToIndex.

	self invalidate
]

{ #category : #drawing }
BlTextElement >> drawDebugInfoOnSpartaCanvas: aCanvas [
	| aBaselineOffset anAscentOffset aDescentOffset aLineWidth |
	
	paragraph
		ifNil: [ ^ self ].

	aLineWidth := 1.0 / self globalScale.

	aCanvas stroke
		path: self boundsInLocal;
		paint: Color red;
		width: aLineWidth;
		draw.

	aBaselineOffset := self baselineOffset.

	anAscentOffset := aBaselineOffset - paragraph ascent.
	aDescentOffset := aBaselineOffset + paragraph descent.

	aCanvas stroke
		path: (aCanvas shape line: 0@aBaselineOffset to: self bounds width @aBaselineOffset);
		paint: Color black;
		width: aLineWidth;
		draw.
	
	aCanvas stroke
		path: (aCanvas shape line: (self width / 2.0) @ 0 to: (self width / 2.0) @ self height);
		paint: Color green muchDarker;
		width: aLineWidth;
		draw.
		
	aCanvas stroke
		path: (aCanvas shape
			line: (BlBounds fromRectangle: (paragraph bounds translateBy: paragraph baseline)) topCenter
			to: (BlBounds fromRectangle: (paragraph bounds translateBy: paragraph baseline)) bottomCenter);
		paint: Color magenta;
		width: aLineWidth;
		draw.
		
	aCanvas stroke
		path: (aCanvas shape line: 0@anAscentOffset to: self bounds width @anAscentOffset);
		paint: Color red;
		width: aLineWidth;
		draw.

	aCanvas stroke
		path: (aCanvas shape line: 0@aDescentOffset to: self bounds width @aDescentOffset);
		paint: Color blue;
		width: aLineWidth;
		draw.

	aCanvas stroke
		path: (paragraph bounds translateBy: paragraph baseline);
		paint: Color gray;
		width: aLineWidth;
		draw.

	aCanvas fill
		path:  (aCanvas shape circleAt: paragraph baseline radius: (10 / self globalScale));
		paint: Color blue;
		draw
]

{ #category : #initialization }
BlTextElement >> initialize [
	super initialize.
	
	text := self defaultText.
	"Text layout is created during measurement in onMeasure:"
	paragraph := nil.
	
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	selection := BlCompositeSelection new.
	measurer := self defaultTextMeasurer.

	self tightMesurement.
	self boundsBaseline.
	
	"self debug: true"
]

{ #category : #'api - text' }
BlTextElement >> looseMesurement [
	self measurement: BlTextElementLooseMeasurementStrategy uniqueInstance
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
		"Create a new text layout"
		ifNil: [ paragraph := self defaultTextParagraph ]
		"or reuse existing"
		ifNotNil: [ paragraph reset ].

	paragraph
		baseline: self baseline;
		text: self text;
		maxWidth: aMaxWidth;
		maxHeight: aMaxHeight;
		scale: self globalScale.

	paragraph measureOn: self measurer.
	"text layout is measured at this point"

	aMeasuredBounds := measurement boundsOf: paragraph.
	aMeasuredWidth := aMeasuredBounds width min: aMaxWidth.
	aMeasuredHeight := aMeasuredBounds height min: aMaxHeight.

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
BlTextElement >> measurer: aTextElementMeasurer [
	measurer := aTextElementMeasurer.
	self textChanged
]

{ #category : #layout }
BlTextElement >> onMeasure: anExtentMeasurementSpec [
	self
		assert: [ text isNotNil ]
		description: [ 'Text model must be nil!' ].

	(self shouldMeasure: anExtentMeasurementSpec)
		ifTrue: [ self measureParagraph: anExtentMeasurementSpec ].
	
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
	<return: #Boolean>

	paragraph
		ifNil: [ ^ true ].

	(self layout previousMeasurementSpec = anExtentMeasurementSpec)
		ifFalse: [ ^ true ].

	paragraph maxWidth = (self computeMaxWidth: anExtentMeasurementSpec)
		ifFalse: [ ^ true ].
		
	paragraph maxHeight = (self computeMaxHeight: anExtentMeasurementSpec)
		ifFalse: [ ^ true ].

	^ false
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

{ #category : #'api - text' }
BlTextElement >> tightMesurement [
	self measurement: BlTextElementTightMeasurementStrategy uniqueInstance
]
