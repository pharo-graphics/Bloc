Class {
	#name : #BlNewBasicHorizontalSlider,
	#superclass : #BlNewBasicSlider,
	#category : #'Bloc-Sliders'
}

{ #category : #'as yet unclassified' }
BlNewBasicHorizontalSlider class >> simpleExample [

	<script>
	| slider textElt space |
	slider := self new position: 50 asPoint.

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

{ #category : #initialization }
BlNewBasicHorizontalSlider >> initialize [ 

	super initialize.
	self extent: 200 @ 50.
]

{ #category : #'private - building' }
BlNewBasicHorizontalSlider >> initializeBar [

	sliderBar := BlElement new.
	sliderBar id: #sliderBar.
	sliderBar height: 10.
	sliderBar constraintsDo: [ :c |
			c frame vertical alignCenter.
			c horizontal matchParent ].
	sliderBar zIndex: 2.

	sliderBar background: Color veryLightGray.
	sliderBar geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self addChild: sliderBar
]

{ #category : #initialization }
BlNewBasicHorizontalSlider >> initializeGraduationsFor: aGraduation [

	| valueDiff stepValues |
	self whenLayoutedDoOnce: [
			aGraduation width: self width - sliderKnob width.
			aGraduation height: 25 ].
	valueDiff := maxValue - minValue.

	stepValues := segmentedValues.
	segmented ifFalse: [
		stepValues := minValue to: maxValue by: aGraduation stepValue ].
	stepValues do: [ :value |
			| element |
			element := ToElement new
				           background: Color black;
				           constraintsDo: [ :c |
						           c vertical matchParent.
						           c horizontal exact: 2.
						           c frame horizontal alignCenterAt:
								           value - minValue / valueDiff ].
			aGraduation addChild: element ]
]

{ #category : #'private - building' }
BlNewBasicHorizontalSlider >> initializeKnob [

	| pt |
	sliderKnob := BlElement new.
	sliderKnob id: #sliderKnob.
	sliderKnob zIndex: 4.
	pt := 20 @ 20.
	sliderKnob
		extent: pt;
		transformDo: [ :t | t translateBy: pt negated x / 2 @ 0 ].
	sliderKnob whenLayoutedDoOnce: [
			sliderKnob constraintsDo: [ :c |
					c frame vertical alignCenter.
					c frame horizontal alignLeftAt: pt x / 2 / self width ] ].

	sliderKnob
		geometry: BlCircleGeometry new;
		background: Color lightRed.
	self addChild: sliderKnob
]

{ #category : #'api - transformations' }
BlNewBasicHorizontalSlider >> moveKnobTo: aPosition [

	| newPos newPosX |
	newPos := aPosition.
	newPosX := newPos x
		           clampBetween: sliderKnob width / 2
		           and: self width - (sliderKnob width / 2).
	newPos := newPosX @ newPos y.

	sliderKnob constraintsDo: [ :c |
		c frame horizontal alignLeftAt: newPosX / self width ].

	self currentValue: (self valueAtCoord: newPos)
]

{ #category : #'api - transformations' }
BlNewBasicHorizontalSlider >> valueAtCoord: aPosition [

	| valueDiff value coeff posX |
	posX := aPosition x.
	posX = (sliderKnob width / 2) ifTrue: [ ^ minValue ].
	valueDiff := maxValue - minValue.
	coeff := self width - sliderKnob width
	         / (posX - (sliderKnob width / 2)).
	value := minValue + (valueDiff / coeff).
	segmented ifTrue: [ value := self nearestValue: value ].

	^ (value roundTo: 1) asFloat
]

{ #category : #'api - transformations' }
BlNewBasicHorizontalSlider >> valueToCoord: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ sliderKnob width / 2
	  + (self width - sliderKnob width * coeff) @ 0
]
