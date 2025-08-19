Class {
	#name : #BlNewBasicVerticalSlider,
	#superclass : #BlNewBasicSlider,
	#category : #'Bloc-Sliders'
}

{ #category : #'as yet unclassified' }
BlNewBasicVerticalSlider class >> simpleExample [

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

	slider newValueCallback: [ :value |
		textElt text: value asRopedText ].
	space show
]

{ #category : #initialization }
BlNewBasicVerticalSlider >> initialize [

	super initialize.
	self extent: 50 @ 200
]

{ #category : #'private - building' }
BlNewBasicVerticalSlider >> initializeBar [

	sliderBar := BlElement new.
	sliderBar id: #sliderBar.
	sliderBar width: 10.
	sliderBar constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c vertical matchParent ].
	sliderBar zIndex: 2.

	sliderBar background: Color veryLightGray.
	sliderBar geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self addChild: sliderBar
]

{ #category : #initialization }
BlNewBasicVerticalSlider >> initializeGraduationsFor: aGraduation [

	| valueDiff stepValues |
	self whenLayoutedDoOnce: [
			aGraduation height: self height - sliderKnob height.
			aGraduation width: 25 ].
	valueDiff := maxValue - minValue.

	stepValues := segmentedValues.
	segmented ifFalse: [
		stepValues := minValue to: maxValue by: aGraduation stepValue ].
	stepValues do: [ :value |
			| element |
			element := ToElement new
				           background: Color black;
				           constraintsDo: [ :c |
						           c horizontal matchParent.
						           c vertical exact: 2.
						           c frame vertical alignCenterAt:
								           1 - (value - minValue / valueDiff) ].
			aGraduation addChild: element ].
]

{ #category : #'private - building' }
BlNewBasicVerticalSlider >> initializeKnob [

	| pt |
	sliderKnob := BlElement new.
	sliderKnob id: #sliderKnob.
	sliderKnob zIndex: 4.
	pt := 20 @ 20.
	sliderKnob
		extent: pt;
		transformDo: [ :t | t translateBy: 0 @ (pt negated y / 2) ].
	sliderKnob whenLayoutedDoOnce: [
			sliderKnob constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTopAt: 1 - (pt y / 2 / self height) ] ].

	sliderKnob
		geometry: BlCircleGeometry new;
		background: Color lightRed.
	self addChild: sliderKnob
]

{ #category : #'api - transformations' }
BlNewBasicVerticalSlider >> moveKnobTo: aPosition [

	| newPos newPosY |
	newPos := aPosition.
	newPosY := newPos y
		           clampBetween: sliderKnob height / 2
		           and: self height - (sliderKnob height / 2).
	newPos := newPos x @ newPosY.

	sliderKnob constraintsDo: [ :c |
			c frame vertical alignment:
				(BlVerticalCoordinateTopAlignment new coordinate:
					 newPosY / self height) ].

	self currentValue: (self valueAtCoord: newPos)
]

{ #category : #'api - transformations' }
BlNewBasicVerticalSlider >> valueAtCoord: aPosition [

	| valueDiff value coeff posY |
	posY := aPosition y.
	posY = (sliderKnob height / 2) ifTrue: [ ^ maxValue ].
	posY = (self height - (sliderKnob height / 2)) ifTrue: [ ^ minValue ].
	valueDiff := maxValue - minValue.
	coeff := self height - sliderKnob height
	         / (posY - (sliderKnob height / 2)).
	value := maxValue - (valueDiff / coeff).
	segmented ifTrue: [ value := self nearestValue: value ].
	
	^ (value roundTo: 1) asFloat
]

{ #category : #'api - transformations' }
BlNewBasicVerticalSlider >> valueToCoord: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ 0 @ self height  - (sliderKnob height / 2
	   + (self height - sliderKnob height * coeff))
]
