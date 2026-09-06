"
This class represents a slider.

This slider aims to be the foundation of a new slider for Toplo, its design is simple and its API aims to gather the basic behaviors of a slider.

This slider was influenced by the `ToDesignSlider` and the `ToOldBasicSlider`.
"
Class {
	#name : #BlNewBasicSlider,
	#superclass : #BlElement,
	#instVars : [
		'minValue',
		'maxValue',
		'currentValue',
		'sliderBar',
		'sliderKnob',
		'newValueCallback',
		'segmented',
		'segmentedValues'
	],
	#category : #'Bloc-Sliders'
}

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleHorizontalSlider [

	<script>
	| slider textElt space |
	slider := BlNewBasicHorizontalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.


	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleHorizontalSliderWithGraduation [

	<script>
	| slider textElt grad space |
	slider := BlNewBasicHorizontalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.

	grad := BlSliderGraduation new.

	grad connectToSlider: slider.

	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleHorizontalSliderWithGraduationAndSegmentation [

	<script>
	| slider textElt grad space |
	slider := BlNewBasicHorizontalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.


	slider beSegmented.
	slider segmentedValues: { 0. 20. 50. 100. 200 }.

	grad := BlSliderGraduation new.

	grad connectToSlider: slider.



	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleHorizontalSliderWithSegmentation [

	<script>
	| slider textElt space |
	slider := BlNewBasicHorizontalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.


	slider beSegmented.
	slider segmentedValues: { 0. 50. 100. 150. 200 }.

	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleVerticalSlider [

	<script>
	| slider textElt space |
	slider := BlNewBasicVerticalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.


	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleVerticalSliderWithGraduation [

	<script>
	| slider textElt grad space |
	slider := BlNewBasicVerticalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.

	grad := BlSliderGraduation new.

	grad connectToSlider: slider.

	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleVerticalSliderWithGraduationAndSegmentation [

	<script>
	| slider textElt grad space |
	slider := BlNewBasicVerticalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.


	slider beSegmented.
	slider segmentedValues: { 0. 20. 50. 100. 200 }.

	grad := BlSliderGraduation new.

	grad connectToSlider: slider.



	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> exampleVerticalSliderWithSegmentation [

	<script>
	| slider textElt space |
	slider := BlNewBasicVerticalSlider new
		          position: 50 asPoint;
		          border: (BlBorder paint: Color lightRed width: 2);
		          maxValue: 200.0.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.


	slider beSegmented.
	slider segmentedValues: { 0. 50. 100. 150. 200 }.

	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'as yet unclassified' }
BlNewBasicSlider class >> fullExample [

	<script>
	| container basicSliderTextElt basicSlider graduatedSliderTextElt graduatedSlider graduation1 segmentedSliderTextElt segmentedSlider graduatedSegmentedSliderTextElt graduatedSegmentedSlider graduation2 |
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             position: 50 asPoint;
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ].


	basicSliderTextElt := BlTextElement new
		                      text: 0.0 asRopedText;
		                      position: 100 @ 0.
	basicSlider := BlNewBasicHorizontalSlider new newValueCallback: [
		               :value | basicSliderTextElt text: value asRopedText ].

	graduatedSliderTextElt := BlTextElement new
		                          text: 0.0 asRopedText;
		                          position: 100 @ 0.
	graduatedSlider := BlNewBasicHorizontalSlider new newValueCallback: [
		                   :value |
		                   graduatedSliderTextElt text: value asRopedText ].
	graduation1 := BlSliderGraduation new connectToSlider:
		               graduatedSlider.

	segmentedSliderTextElt := BlTextElement new
		                          text: 0.0 asRopedText;
		                          position: 100 @ 0.
	segmentedSlider := BlNewBasicHorizontalSlider new beSegmented
		                   segmentedValues: { 0. 25. 50. 75. 100 };
		                   newValueCallback: [ :value |
			                   segmentedSliderTextElt text: value asRopedText ].

	graduatedSegmentedSliderTextElt := BlTextElement new
		                                   text: 0.0 asRopedText;
		                                   position: 100 @ 0.
	graduatedSegmentedSlider := BlNewBasicHorizontalSlider new
		                            beSegmented
		                            segmentedValues: { 0. 25. 50. 75. 100 };
		                            newValueCallback: [ :value |
			                            graduatedSegmentedSliderTextElt text:
					                            value asRopedText ].
	graduation2 := BlSliderGraduation new connectToSlider:
		               graduatedSegmentedSlider.

	container addChildren: {
			basicSlider.
			basicSliderTextElt.
			graduatedSlider.
			graduatedSliderTextElt.
			segmentedSlider.
			segmentedSliderTextElt.
			graduatedSegmentedSlider.
			graduatedSegmentedSliderTextElt }.

	container openInSpace.

	2 seconds wait.
	0 to: 100 do: [ :i |
			basicSlider setValue: i.
			graduatedSlider setValue: i.
			segmentedSlider setValue: i.
			graduatedSegmentedSlider setValue: i.
			0.03 seconds wait ].
	100 to: 0 by: -1 do: [ :i |
			basicSlider setValue: i.
			graduatedSlider setValue: i.
			segmentedSlider setValue: i.
			graduatedSegmentedSlider setValue: i.
			0.03 seconds wait ]
]

{ #category : #building }
BlNewBasicSlider >> beSegmented [ 

	segmented := true
]

{ #category : #building }
BlNewBasicSlider >> beSmooth [

	segmented := false.
]

{ #category : #private }
BlNewBasicSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
BlNewBasicSlider >> currentValue: aNumber [

	currentValue := aNumber.
	self newValueCallback ifNotNil: [ :e | e value: currentValue ]
]

{ #category : #initialization }
BlNewBasicSlider >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self clipChildren: false.
	self beSmooth.
	self initializeDefaultValues.
	self initializeEvents.
	self initializeBar.
	self initializeKnob
]

{ #category : #'private - building' }
BlNewBasicSlider >> initializeBar [

	self subclassResponsibility 
]

{ #category : #accessing }
BlNewBasicSlider >> initializeDefaultValues [

	maxValue := 100.0.
	minValue := 0.0.
	currentValue := 0.0.
]

{ #category : #initialization }
BlNewBasicSlider >> initializeEvents [

	self
		addEventHandlerOn: BlMouseDownEvent
		do: [ :event |
		self mouseAt: (self globalPointToLocal: event position) ].
	self
		addEventHandlerOn: BlDragStartEvent
		do: [ :event | event consume ].
	self
		addEventHandlerOn: BlDragEvent
		do: [ :event |
		self mouseAt: (self globalPointToLocal: event position) ]
]

{ #category : #initialization }
BlNewBasicSlider >> initializeGraduationsFor: aGraduation [ 

	self subclassResponsibility 
]

{ #category : #'private - building' }
BlNewBasicSlider >> initializeKnob [

	self subclassResponsibility 
]

{ #category : #'api - values' }
BlNewBasicSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
BlNewBasicSlider >> maxValue: anObject [

	maxValue := anObject
]

{ #category : #'api - values' }
BlNewBasicSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
BlNewBasicSlider >> minValue: aNumber [

	minValue := aNumber.
]

{ #category : #accessing }
BlNewBasicSlider >> mouseAt: aPosition [

	| newPosition |
	segmented ifFalse: [
			self moveKnobTo: aPosition.
			^ self ].
	newPosition := self valueToCoord: (self valueAtCoord: aPosition).
	self moveKnobTo: newPosition
]

{ #category : #'api - transformations' }
BlNewBasicSlider >> moveKnobTo: aPosition [

	self subclassResponsibility 
]

{ #category : #'api - values' }
BlNewBasicSlider >> nearestValue: aValue [

	| nearestValue mininumGap segmentedToCompare currentGap |
	segmented ifFalse: [ ^ aValue ].
	nearestValue := segmentedValues first.
	mininumGap := (aValue - nearestValue) abs.
	2 to: segmentedValues size do: [ :e |
			segmentedToCompare := segmentedValues at: e.
			currentGap := (aValue - segmentedToCompare) abs.
			currentGap < mininumGap ifTrue: [
					mininumGap := currentGap.
					nearestValue := segmentedToCompare ] ].
	^ nearestValue
]

{ #category : #private }
BlNewBasicSlider >> newValueCallback [

	^ newValueCallback
]

{ #category : #'api - values' }
BlNewBasicSlider >> newValueCallback: anObject [

	newValueCallback := anObject
]

{ #category : #accessing }
BlNewBasicSlider >> segmentedValues: aCollection [ 

	segmentedValues := aCollection
]

{ #category : #'api - slider' }
BlNewBasicSlider >> setToMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
BlNewBasicSlider >> setToMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
BlNewBasicSlider >> setValue: aValue [

	self mouseAt: (self valueToCoord: aValue)
]

{ #category : #accessing }
BlNewBasicSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
BlNewBasicSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #accessing }
BlNewBasicSlider >> sliderKnob [

	^ sliderKnob
]

{ #category : #accessing }
BlNewBasicSlider >> sliderKnob: anObject [

	sliderKnob := anObject
]

{ #category : #'api - transformations' }
BlNewBasicSlider >> valueAtCoord: aPosition [

	self subclassResponsibility 
]

{ #category : #'api - transformations' }
BlNewBasicSlider >> valueToCoord: aValue [

	self subclassResponsibility 
]
