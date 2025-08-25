"
This class represents a slider.

This slider was originally created to experiment how to create a slider with Bloc and try different advanced behaviours.

This slider is not properly working at the time but we can still explore its code to extract some interesting things and implement them later into the new `ToNewBasicSlider`


"
Class {
	#name : #BlOldBasicSlider,
	#superclass : #BlElement,
	#instVars : [
		'minValue',
		'maxValue',
		'stepValue',
		'sliderPixelMargin',
		'currentValue',
		'validatedValue',
		'validatedValueCallback',
		'sliderBar',
		'sliderBackground',
		'disabledRebuilding',
		'widgetSize',
		'maxPixelDistance',
		'enumeratedValues',
		'enumeratedColors',
		'initColor',
		'endColor',
		'barThickness',
		'isHorizontal',
		'eventHandler',
		'sliderHandle',
		'handlePushedPoint'
	],
	#category : #'Bloc-Sliders'
}

{ #category : #building }
BlOldBasicSlider class >> backgroundDefaultColor [

	^ Color gray
]

{ #category : #building }
BlOldBasicSlider class >> barDefaultColor [

	^ Color blue 
]

{ #category : #building }
BlOldBasicSlider class >> defaultMaxPixelDistance [

	^ 25
]

{ #category : #testing }
BlOldBasicSlider class >> exampleSegmented [

	<script>
	| bl |
	bl := self new.
	bl minValue: 0.
	bl maxValue: 20.
	bl stepValue: 1.
	bl enumeratedValues: #( 0 5 10 15 20 ).
	bl sliderPixelMargin: 20.
	bl size: 500 @ 25.
	bl buildSlider.
	bl validatedValueCallback: [ :e | "self changedTimeValue: e" ].
	bl margin: (BlInsets top: 5).
	bl openInSpace
]

{ #category : #testing }
BlOldBasicSlider class >> exampleSegmentedWithColors [

	<script>
	| bl2 |
	bl2 := self new.
	bl2 enumeratedColors: {
			Color lightBlue.
			Color blue.
			Color orange.
			Color red }.
	bl2 position: 0 @ 20.
	bl2 minValue: 50.
	bl2 maxValue: 200.
	bl2 stepValue: 50.
	bl2 size: 550 @ 48.
	bl2 sliderPixelMargin: 35.
	bl2 buildSlider.
	bl2 validatedValueCallback: [ :e | "self changedOperationalActivityValue: e"
		 ].
	bl2 openInSpace.
]

{ #category : #building }
BlOldBasicSlider class >> interactionDefaultColor [

	^ Color pink alpha: 0.5
]

{ #category : #building }
BlOldBasicSlider class >> interactorDefaultColor [

	^ Color red 
]

{ #category : #testing }
BlOldBasicSlider class >> visualTestNotSegmented [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 1.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	"	bl validatedValueCallback: [ :e | e inspect ]."
	^ val
]

{ #category : #testing }
BlOldBasicSlider class >> visualTestNotSegmentedInspectValue [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 1.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	bl validatedValueCallback: [ :e | e inspect ].
	^ val
]

{ #category : #testing }
BlOldBasicSlider class >> visualTestSegmented [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 55.
	bl maxValue: 75.
	bl stepValue: 5.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	^ val
]

{ #category : #accessing }
BlOldBasicSlider >> barThickness: anObject [

	barThickness := anObject
]

{ #category : #'main configuration' }
BlOldBasicSlider >> beHorizontal [

	self horizontal: true.
]

{ #category : #'main configuration' }
BlOldBasicSlider >> beVertical [

	self horizontal: false.
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildDefaultHandle [

	| bl pt |
	pt := 20 @ 20.
	bl := ToElement new
		      geometry: BlCircleGeometry new;
		      background: self class interactorDefaultColor;
		      extent: pt;
		      transformDo: [ :t | t translateBy: pt negated / 2 ].
	^ bl
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildForeground [ 

	self id: #sliderInteractionForeground.
	self size: self widgetSize.
	self background: self class interactionDefaultColor.
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildHorizontalBackground [

	| bgElt |
	bgElt := ToElement new.
	bgElt extent:
		self widgetSize x - (2 * self sliderPixelMargin) @ barThickness.
	bgElt id: #sliderBackground.
	bgElt position:
		self sliderPixelMargin
		@ (self widgetSize y / 2 - (barThickness / 2)).
	bgElt background: self class backgroundDefaultColor.
	bgElt zIndex: 0.
	self addChild: bgElt.
	self sliderBackground: bgElt
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildHorizontalBar [

	| bar |
	bar := ToElement new.
	bar extent:
		(self valueToCoord: currentValue) - self sliderPixelMargin
		@ barThickness.
	bar id: #sliderBar.
	bar position:
		self sliderPixelMargin
		@ (self widgetSize y / 2 - (barThickness / 2)).
	bar background: self class barDefaultColor.
	bar zIndex: 2.
	self addChild: bar.
	self sliderBar: bar
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildHorizontalHandle [ 

	| handle pt |
	handle := self buildDefaultHandle.
	handle id: #sliderHandle.
	pt := (self valueToCoord: currentValue)
	      @ (self widgetSize y / 2).
	handle position: pt.
	handle zIndex: 3.
	self addChild: handle.
	self sliderHandle: handle
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildHorizontalSlider [

	self buildForeground.
	self buildHorizontalBackground.
	self buildHorizontalBar.
	self buildHorizontalHandle
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildSlider [

	self removeAllShapes.
	self size: self widgetSize.
	self isHorizontal
		ifTrue: [ self buildHorizontalSlider ]
		ifFalse: [ self buildVerticalSlider ].
	self initializeEventHandlers
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildVerticalBackground [

	
	| bgElt pt1 pt2 |
	bgElt := ToElement new.
	pt1 := barThickness
	       @ (self widgetSize y - (2 * self sliderPixelMargin)).
	bgElt size: pt1.
	bgElt id: #sliderBackground.
	pt2 := self widgetSize x / 2 - ( barThickness / 2)
	       @ self sliderPixelMargin.
	bgElt position: pt2.
	bgElt background: self class backgroundDefaultColor.
	bgElt zIndex: 0.
	self addChild: bgElt.
	self sliderBackground: bgElt.

]

{ #category : #'private - building' }
BlOldBasicSlider >> buildVerticalBar [

	| bar |
	bar := ToElement new.
	bar size: barThickness
		@ (self widgetSize y - (self valueToCoord: currentValue)
			 - self sliderPixelMargin).
	bar id: #sliderBar.
	bar position: self widgetSize x / 2 - (barThickness / 2)
		@ (self valueToCoord: currentValue).
	bar background: self class barDefaultColor.
	bar zIndex: 2.
	self addChild: bar.
	self sliderBar: bar.

	
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildVerticalHandle [

	| handle pt |

	handle := self buildDefaultHandle.
	handle id: #sliderHandle.
	pt := self widgetSize x / 2 @ (self valueToCoord: currentValue).
	handle position: pt.
	handle zIndex: 3.
	self addChild: handle.
	self sliderHandle: handle
]

{ #category : #'private - building' }
BlOldBasicSlider >> buildVerticalSlider [

	self buildForeground.
	self buildVerticalBackground.
	self buildVerticalBar.
	self buildVerticalHandle
]

{ #category : #'changing state' }
BlOldBasicSlider >> changedCurrentValue: aValue [

^self changedCurrentValue: aValue withSlider: false
]

{ #category : #'changing state' }
BlOldBasicSlider >> changedCurrentValue: aValue withSlider: aBool [

	| v color |
	v := self valueToCoord: aValue.
	self isHorizontal
		ifTrue: [
				aBool ifTrue: [
						self sliderHandle ifNotNil: [ :sl |
							sl position: v @ sl constraints position y ] ].
				self sliderBar extent:
					v - self sliderPixelMargin @ self sliderBar extent y ]
		ifFalse: [
				aBool ifTrue: [
						self sliderHandle ifNotNil: [ :sl |
							sl position: sl constraints position x @ v ] ].
				self sliderBar size:
					barThickness
					@ (self widgetSize y - (self valueToCoord: currentValue)
						 - self sliderPixelMargin).
				self sliderBar position:
					self widgetSize x / 2 - (barThickness / 2)
					@ (self valueToCoord: currentValue) ].
	color := self colorForValue: aValue.
	self sliderHandle background: color.
	self sliderBar background: color
]

{ #category : #'changing state' }
BlOldBasicSlider >> changedHandlePosition: v [

	self isHorizontal 
		ifTrue: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: v @ sl constraints position y ] ]
		ifFalse: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: sl constraints position x @ v ] ]
]

{ #category : #private }
BlOldBasicSlider >> cleanSliderParts [

	sliderBackground := nil.
	sliderBar := nil.
	sliderHandle := nil
]

{ #category : #private }
BlOldBasicSlider >> colorForValue: aValue [

	| i |
	self enumeratedColors
		ifNil: [
			^  endColor
				  mixed: (self proportionOf: aValue)
				  with: self initColor ]
		ifNotNil: [ :list |
			i := self enumeratedValues indexOf: aValue.
			i = 0 ifTrue: [ ^ self initColor ].
			(i > list size) ifTrue: [ ^  endColor ].
			^list at: i ]
]

{ #category : #private }
BlOldBasicSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
BlOldBasicSlider >> currentValue: aNumber [

	(aNumber between: minValue and: maxValue) ifFalse: [ ^ self ].
	currentValue := aNumber.
	self changedCurrentValue: aNumber
]

{ #category : #'api - slider' }
BlOldBasicSlider >> decrementValue [

	self decrementValue: self stepValue.
]

{ #category : #'api - slider' }
BlOldBasicSlider >> decrementValue: aValue [

	| tmp |
	tmp := validatedValue - aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlOldBasicSlider >> disabledRebuilding [

	^ disabledRebuilding
]

{ #category : #accessing }
BlOldBasicSlider >> disabledRebuilding: anObject [

	disabledRebuilding := anObject
]

{ #category : #accessing }
BlOldBasicSlider >> endColor: anObject [

	endColor := anObject
]

{ #category : #accessing }
BlOldBasicSlider >> enumeratedColors [

	^ enumeratedColors
]

{ #category : #accessing }
BlOldBasicSlider >> enumeratedColors: anObject [

	enumeratedColors := anObject
]

{ #category : #'api - values' }
BlOldBasicSlider >> enumeratedValues [
	"since the enumerated value are derived from min, max and step, we lazy initialize it."
	
	enumeratedValues ifNil: [
		enumeratedValues := (self minValue to: self maxValue by:
		                     self stepValue) asOrderedCollection ].
	^ enumeratedValues
]

{ #category : #accessing }
BlOldBasicSlider >> enumeratedValues: anObject [

	enumeratedValues := anObject
]

{ #category : #accessing }
BlOldBasicSlider >> handlePushedPoint [

	^ handlePushedPoint
]

{ #category : #accessing }
BlOldBasicSlider >> handlePushedPoint: anObject [

	handlePushedPoint := anObject
]

{ #category : #accessing }
BlOldBasicSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #'api - slider' }
BlOldBasicSlider >> incrementValue [

	self incrementValue: self stepValue
]

{ #category : #'api - slider' }
BlOldBasicSlider >> incrementValue: aValue [

	| tmp |
	tmp := validatedValue + aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlOldBasicSlider >> initColor [

	^ initColor
]

{ #category : #accessing }
BlOldBasicSlider >> initColor: anObject [

	initColor := anObject
]

{ #category : #initialization }
BlOldBasicSlider >> initialize [

	super initialize.
	barThickness := 8.
	maxValue := 100.0.
	minValue := 0.0.
	self size: 300 @ 30.
	currentValue := 0.0.
	self beHorizontal.
	sliderPixelMargin := 5.
	disabledRebuilding := false.
	stepValue := 1.
	endColor := self class interactorDefaultColor.
	initColor := self class interactorDefaultColor.
	maxPixelDistance := self class defaultMaxPixelDistance
]

{ #category : #initialization }
BlOldBasicSlider >> initializeEventHandlers [

	eventHandler := BlOldBasicSliderHandler new.
	self addEventHandler: eventHandler
]

{ #category : #private }
BlOldBasicSlider >> is: aValue near: aValue2 [

	^(aValue - aValue2) abs < self maxPixelDistance
]

{ #category : #accessing }
BlOldBasicSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #'private - building' }
BlOldBasicSlider >> isSliderBuilt [
	"if no interactor, no slider"

	^ self sliderHandle isNotNil
]

{ #category : #accessing }
BlOldBasicSlider >> maxPixelDistance [

	^ maxPixelDistance 
]

{ #category : #accessing }
BlOldBasicSlider >> maxPixelDistance: anObject [

	maxPixelDistance := anObject
]

{ #category : #'api - values' }
BlOldBasicSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
BlOldBasicSlider >> maxValue: anObject [
	"when we change the maxValue, we are rebuilding the enumerated values and slider"

	maxValue := anObject.
	enumeratedValues := nil.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlOldBasicSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
BlOldBasicSlider >> minValue: anObject [

	minValue := anObject.
	enumeratedValues := nil.
	currentValue < minValue ifTrue: [ currentValue := minValue copy ].
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlOldBasicSlider >> nearestValue: aValue [

	| val minResult tmp tmp2 |
	self enumeratedValues ifNil: [ ^ aValue ].
	self enumeratedValues isEmpty ifTrue: [ ^ aValue ].
	val := self enumeratedValues first.
	minResult := (aValue - val) abs.
	2 to: enumeratedValues size do: [ :e |
		tmp := self enumeratedValues at: e.
		tmp2 := (aValue - tmp) abs.
		tmp2 < minResult ifTrue: [
			minResult := tmp2.
			val := tmp ] ].
	^ val
]

{ #category : #'api - transformations' }
BlOldBasicSlider >> pointToValue: point [

	^ self isHorizontal 
		  ifTrue: [ self pointToXValue: point ]
		  ifFalse: [ self pointToYValue: point ]
]

{ #category : #'api - transformations' }
BlOldBasicSlider >> pointToXValue: point [

	| facteur valeur |
	facteur := point x / self sliderBackground extent x.
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #'api - transformations' }
BlOldBasicSlider >> pointToYValue: point [

	| facteur valeur |
	facteur := 1 - (point y / self sliderBackground size y).
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #private }
BlOldBasicSlider >> proportionOf: aValue [
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)
]

{ #category : #'private - building' }
BlOldBasicSlider >> rebuildSlider [

	self disabledRebuilding ifTrue: [ ^ self ].
	self buildSlider
]

{ #category : #private }
BlOldBasicSlider >> removeAllShapes [

	| list |
	list := self sliderParts.
	"BlCleanSlider>>sliderParts is only called here and returns the same thing as BlElement>>children"
	self removeEventHandler.
	self removeChildren: list.
	self cleanSliderParts
]

{ #category : #private }
BlOldBasicSlider >> removeEventHandler [

	eventHandler ifNil: [ ^ self ].
	self flag: #toClean. "we should not test this"
	
	self removeEventHandler: eventHandler.
	eventHandler := nil.
	
]

{ #category : #'api - slider' }
BlOldBasicSlider >> setMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
BlOldBasicSlider >> setToMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
BlOldBasicSlider >> setValue: aValue [

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].
]

{ #category : #'api - bounds' }
BlOldBasicSlider >> size: aValue [

	super extent: aValue.
	self widgetSize: aValue.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #accessing }
BlOldBasicSlider >> sliderBackground [

	^ sliderBackground
]

{ #category : #accessing }
BlOldBasicSlider >> sliderBackground: anObject [

	sliderBackground := anObject
]

{ #category : #accessing }
BlOldBasicSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
BlOldBasicSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #'events - bar' }
BlOldBasicSlider >> sliderBarClicked: event [

	| tmp val |
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	self validatedValue: val.
]

{ #category : #accessing }
BlOldBasicSlider >> sliderHandle [

	^ sliderHandle
]

{ #category : #accessing }
BlOldBasicSlider >> sliderHandle: anObject [

	sliderHandle := anObject
]

{ #category : #'events - interactor' }
BlOldBasicSlider >> sliderHandleMoved: event [

	| val tmp v |
	self handlePushedPoint ifNil: [ ^ self ].
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	tmp := self globalPointToLocal: event position.
	self isHorizontal
		ifTrue: [
			v := tmp x.
			v := v min: (self valueToX: self maxValue).
			v := v max: (self valueToX: self minValue) ]
		ifFalse: [
			v := tmp y.
			v := v min: (self valueToY: self minValue).
			v := v max: (self valueToY: self maxValue) ].

	self changedHandlePosition: v.
	self currentValue: val
]

{ #category : #'events - interactor' }
BlOldBasicSlider >> sliderHandlePushed: event [

	| value pt1 pt2 |
	self sliderBar ifNil: [ ^ self ].
	value := self pointToValue:
		         (self sliderBackground globalPointToLocal: event position).
	pt1 := self valueToX: value.
	pt2 := self valueToX: currentValue.
	(self is: pt1 near: pt2) ifTrue: [
		self handlePushedPoint: event position copy ]
]

{ #category : #'events - interactor' }
BlOldBasicSlider >> sliderHandleReleased [

	self handlePushedPoint ifNil: [ ^ self ].
	self handlePushedPoint: nil.
	self validatedValue: currentValue
]

{ #category : #private }
BlOldBasicSlider >> sliderParts [

	| oc |
	oc := OrderedCollection new.
	self sliderBackground ifNotNil: [ :e | oc add: e ].
	self sliderBar ifNotNil: [ :e | oc add: e ].
	self sliderHandle ifNotNil: [ :e | oc add: e ].
	^ oc
]

{ #category : #accessing }
BlOldBasicSlider >> sliderPixelMargin [

	^ sliderPixelMargin 
]

{ #category : #accessing }
BlOldBasicSlider >> sliderPixelMargin: anObject [

	sliderPixelMargin := anObject.
	self isSliderBuilt ifTrue: [ 
		self rebuildSlider ]
]

{ #category : #'api - values' }
BlOldBasicSlider >> stepValue [

	^ stepValue
]

{ #category : #'api - values' }
BlOldBasicSlider >> stepValue: anObject [

	stepValue := anObject.
	enumeratedValues := nil.
]

{ #category : #'api - values' }
BlOldBasicSlider >> validatedValue [

	^ validatedValue
]

{ #category : #'api - values' }
BlOldBasicSlider >> validatedValue: aValue [

	currentValue := aValue.
	self changedCurrentValue: aValue withSlider: true. 
	validatedValue := aValue.
	self validatedValueCallback ifNotNil: [ :e | e value: validatedValue ]
]

{ #category : #private }
BlOldBasicSlider >> validatedValueCallback [

	^ validatedValueCallback
]

{ #category : #'api - values' }
BlOldBasicSlider >> validatedValueCallback: anObject [

	validatedValueCallback := anObject
]

{ #category : #'api - transformations' }
BlOldBasicSlider >> valueToCoord: aValue [

	^ self isHorizontal 
		  ifTrue: [ self valueToX: aValue ]
		  ifFalse: [ self valueToY: aValue ]
]

{ #category : #'api - transformations' }
BlOldBasicSlider >> valueToX: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ self sliderPixelMargin
	  + (self sliderBackground constraints horizontal resizer size * coeff roundTo: 1)
]

{ #category : #'api - transformations' }
BlOldBasicSlider >> valueToY: aValue [

	| valeurCourante valeurTotale facteur |
	valeurCourante := aValue - self minValue.
	valeurTotale := self maxValue - self minValue.
	facteur := 1 - (valeurCourante / valeurTotale).
	^ self sliderPixelMargin
	  +
		  (self sliderBackground constraints vertical resizer size * facteur
			   roundTo: 1)
]

{ #category : #accessing }
BlOldBasicSlider >> widgetSize [

	^ widgetSize
]

{ #category : #private }
BlOldBasicSlider >> widgetSize: anObject [

	widgetSize := anObject
]
