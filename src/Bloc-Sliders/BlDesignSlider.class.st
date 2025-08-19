"
This class represents a slider.

This slider was originally created for the CoypuIDE project and it is not properly working at the current time, but we can still explore its code to extract some interesting things and implement them later into the new `ToNewBasicSlider`  
"
Class {
	#name : #BlDesignSlider,
	#superclass : #BlElement,
	#instVars : [
		'widgetSize',
		'handle',
		'bar',
		'coloredBar',
		'isHorizontal',
		'minValue',
		'maxValue',
		'stepValue',
		'barThickness',
		'barLength',
		'marginThickness',
		'marginLength',
		'segmented',
		'segmentedValues',
		'callBack',
		'overlayer',
		'value',
		'minLabel',
		'maxLabel',
		'label',
		'valueLabel',
		'name'
	],
	#category : #'Bloc-Sliders'
}

{ #category : #accessing }
BlDesignSlider class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : #accessing }
BlDesignSlider class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : #accessing }
BlDesignSlider class >> label: aString [ 

	|slider|
	slider := self new name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : #'instance creation' }
BlDesignSlider class >> new [

	^ self readOnly initializeEvents
]

{ #category : #'instance creation' }
BlDesignSlider class >> readOnly [

	^ self basicNew initialize
]

{ #category : #'instance creation' }
BlDesignSlider class >> readOnlyLabel: aString [

	| slider |
	slider := self readOnly name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : #'as yet unclassified' }
BlDesignSlider class >> simpleExampleHorizontal [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beHorizontal.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider value asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : #'as yet unclassified' }
BlDesignSlider class >> simpleExampleVertical [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beVertical.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider value asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : #accessing }
BlDesignSlider >> bar [
	^ bar
]

{ #category : #accessing }
BlDesignSlider >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : #'api - bounds' }
BlDesignSlider >> barDefaultColor [ 

	^ Color lightGray

]

{ #category : #accessing }
BlDesignSlider >> barLength [

	^ barLength
]

{ #category : #accessing }
BlDesignSlider >> barLength: aNumber [

	barLength := aNumber.
	self rebuild
]

{ #category : #accessing }
BlDesignSlider >> barThickness [ 

	^ barThickness 
]

{ #category : #accessing }
BlDesignSlider >> barThickness: aNumber [

	barThickness := aNumber.
	self rebuild
]

{ #category : #'api - values' }
BlDesignSlider >> basicSetValue: aNumber [

	value := aNumber.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : #accessing }
BlDesignSlider >> beHorizontal [

	self horizontal: true.
	self rebuild
]

{ #category : #building }
BlDesignSlider >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true].
	self rebuild
]

{ #category : #building }
BlDesignSlider >> beSmooth [

	self segmented: false.
	self segmentedValues: nil.
	self rebuild
]

{ #category : #accessing }
BlDesignSlider >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : #building }
BlDesignSlider >> buildHorizontal [

	widgetSize y > widgetSize x ifTrue: [
		self widgetSize: widgetSize y @ widgetSize x ].
	self removeParts.
	self initializeParts
]

{ #category : #building }
BlDesignSlider >> buildVertical [

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts
]

{ #category : #accessing }
BlDesignSlider >> callBack [ 

	^ callBack 
]

{ #category : #accessing }
BlDesignSlider >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : #'as yet unclassified' }
BlDesignSlider >> changeMaxValueLabelTo: aValue [

	maxLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	maxValue := aValue
]

{ #category : #'as yet unclassified' }
BlDesignSlider >> changeMinValueLabelTo: aValue [

	minLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	valueLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color black).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).

	minValue := aValue.
	value := aValue
]

{ #category : #accessing }
BlDesignSlider >> coloredBar [ 

	^ coloredBar 
]

{ #category : #accessing }
BlDesignSlider >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : #accessing }
BlDesignSlider >> coloredBarDefaultColor [
	^ Color green alpha: 0.6
]

{ #category : #'api - slider' }
BlDesignSlider >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultBar [

	| size |
	size := self
		        ifHorizontal: [
		        self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [
		        self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self barDefaultColor;
		  size: size;
		constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultBarLength [

	^ 100
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultBarThickness [

	^ 20
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultColor [

	^ Color veryDarkGray
]

{ #category : #accessing }
BlDesignSlider >> defaultColoredBar [

	| size |
	size := self
		        ifHorizontal: [ 0 @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ 0.1 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self coloredBarDefaultColor;
		constraintsDo: [ :c | c ignoreByLayout ];
		  size: size;
		  yourself
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultHandle [

	| size elt |
	size := self
		        ifHorizontal: [ 5 @ barThickness ]
		        ifVertical: [ barThickness @ 5 ].

	elt := BlElement new
		       background: self handleDefaultColor;
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		constraintsDo: [ :c | c ignoreByLayout ];
		       size: size;
		       transformDo: [ :t | "so the position is now the center"
			       t translateBy: size negated / 2 ];
		       yourself.

	^ elt
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultMarginLength [

	^ 5
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultMarginThickness [

	^ 5
]

{ #category : #'api - bounds' }
BlDesignSlider >> defaultSize [
	"self bar size maybe"

	^ self
		  ifHorizontal: [
			  self defaultBarLength + (2 * self defaultMarginLength)
			  @ (self defaultBarThickness + (2 * self defaultMarginThickness)) ]
		  ifVertical: [
			  self defaultBarThickness + (2 * self defaultMarginThickness)
			  @ (self defaultBarLength + (2 * self defaultMarginLength)) ]
]

{ #category : #accessing }
BlDesignSlider >> direction [
	"Returns true if horizontal else false"
	^ self ifHorizontal: [ true ]
			 ifVertical: [ false ].
]

{ #category : #accessing }
BlDesignSlider >> handle [
	^ handle
]

{ #category : #accessing }
BlDesignSlider >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : #'api - bounds' }
BlDesignSlider >> handleDefaultColor [

	^ Color green
]

{ #category : #accessing }
BlDesignSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #building }
BlDesignSlider >> ifHorizontal: horizontalBlock ifVertical: verticalBlock [

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock
]

{ #category : #'api - slider' }
BlDesignSlider >> incrementValue: aValue [

	| tmp |
	tmp := value + aValue.
	self setValue: tmp
]

{ #category : #initialization }
BlDesignSlider >> initialize [

	super initialize.
	isHorizontal := true.
	segmented := false.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self layout: BlFrameLayout new.
	self initializeValues.
	self initializeParts.
	self initializeValueLabels
	"self initializeEvents"
]

{ #category : #initialization }
BlDesignSlider >> initializeEvents [ 

	self addEventHandlerOn: BlMouseDownEvent do: [ :event |
		self moveHandleTo: (self globalPointToLocal: event position)].
	self addEventHandlerOn: BlDragStartEvent do: [ :event | event consumed: true].
	self addEventHandlerOn: BlDragEvent do: [ :event | self moveHandleTo: (self globalPointToLocal: event position)]
]

{ #category : #initialization }
BlDesignSlider >> initializeLabel [

	label := BlTextElement new.
	label text: (self name asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	label text fontSize: 15.
	label text bold.
	label constraintsDo: [ :c |
		c padding: (BlInsets all: 5).
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	self addChild: label
]

{ #category : #initialization }
BlDesignSlider >> initializeParts [

	self bar: self defaultBar.
	self positionDefaultBar: self bar.
	self addChild: self bar.


	self coloredBar: self defaultColoredBar.
	self positionDefaultBar: self coloredBar.
	self addChild: self coloredBar.


	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle

	"initialize segments if segmented"

	"self initializeButtons."
]

{ #category : #initialization }
BlDesignSlider >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : #initialization }
BlDesignSlider >> initializeValueLabels [

	minLabel := BlTextElement new
		            text: (self minValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            c padding: (BlInsets horizontal: 15).
			            c frame horizontal alignLeft.
			            c frame vertical alignCenter ].

	maxLabel := BlTextElement new
		            text: (self maxValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            c padding: (BlInsets horizontal: 15).
			            c frame horizontal alignRight.
			            c frame vertical alignCenter ].

	valueLabel := BlTextElement new
		              text: (self value asRopedText attributes: {
						               (BlTextForegroundAttribute paint: Color black).
						               (BlFontSizeAttribute size: 15).
						               BlFontWeightAttribute bold });
		              constraintsDo: [ :c |
			              c frame horizontal alignCenter.
			              c frame vertical alignCenter ].

	self addChild: minLabel.
	self addChild: valueLabel.
	self addChild: maxLabel.

	self callBack: [ :v |
		valueLabel text: (v rounded asRopedText attributes: {
					 (BlTextForegroundAttribute paint: Color black).
					 (BlFontSizeAttribute size: 15).
					 BlFontWeightAttribute bold }) ]
]

{ #category : #initialization }
BlDesignSlider >> initializeValues [

	self minValue: 0.
	self maxValue: 50.
	value := self minValue 
]

{ #category : #accessing }
BlDesignSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #testing }
BlDesignSlider >> isSegmented [ 

	^ segmented 
]

{ #category : #accessing }
BlDesignSlider >> label [

	^ label
]

{ #category : #accessing }
BlDesignSlider >> marginLength [

	^ marginLength
]

{ #category : #accessing }
BlDesignSlider >> marginLength: aNumber [

	marginLength := aNumber.
	self rebuild
]

{ #category : #accessing }
BlDesignSlider >> marginThickness [ 

	^ marginThickness 
]

{ #category : #accessing }
BlDesignSlider >> marginThickness: aNumber [

	marginThickness := aNumber.
	self rebuild
]

{ #category : #accessing }
BlDesignSlider >> maxLabel [

	^ maxLabel
]

{ #category : #accessing }
BlDesignSlider >> maxValue [

	^ maxValue
]

{ #category : #accessing }
BlDesignSlider >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #accessing }
BlDesignSlider >> minLabel [ 

	^ minLabel 
]

{ #category : #accessing }
BlDesignSlider >> minValue [ 

	^ minValue 
]

{ #category : #accessing }
BlDesignSlider >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : #'api - transformations' }
BlDesignSlider >> moveHandleTo: aPosition [

	| newPos |
	newPos := aPosition.
	"deal with segmentation"
	self isSegmented ifTrue: [
		| value |
		value := self valueAtCoord: aPosition.
		newPos := self valueToCoord: value ].
	self
		ifHorizontal: [
			| newPosX |
			newPosX := newPos x.
			newPos x < bar position x ifTrue: [ newPosX := bar position x ].
			newPos x > (bar position x + barLength) ifTrue: [
				newPosX := bar position x + barLength ].
			newPos := newPosX @ handle position y.
			handle position: newPos ]
		ifVertical: [
			| newPosY |
			newPosY := newPos y.
			newPos y < bar position y ifTrue: [ newPosY := bar position y ].
			newPos y > (bar position y + barLength) ifTrue: [
				newPosY := bar position y + barLength ].
			newPos := handle position x @ newPosY.
			handle position: newPos ].
	self updateColoredBarTo: newPos.
	self basicSetValue: (self valueAtCoord: newPos)
]

{ #category : #accessing }
BlDesignSlider >> name [ 

	^ name
]

{ #category : #accessing }
BlDesignSlider >> name: aString [

	name := aString.
	self initializeLabel.
]

{ #category : #'api - values' }
BlDesignSlider >> nearestValue: aValue [

	| val minResult tmp tmp2 values |
	self isSegmented ifFalse: [ ^ aValue].
	values := self segmentedValues.
	val := values first.
	minResult := (aValue - val) abs.
	2 to: values size do: [ :e |
		tmp := values at: e.
		tmp2 := (aValue - tmp) abs.
		tmp2 < minResult ifTrue: [
			minResult := tmp2.
			val := tmp ] ].
	^ val
]

{ #category : #'api - transformations' }
BlDesignSlider >> positionDefaultBar: aBar [

	self
		ifHorizontal: [
			aBar position:
				self defaultMarginLength @ self defaultMarginThickness ]
		ifVertical: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength ]
]

{ #category : #'api - transformations' }
BlDesignSlider >> positionDefaultHandle [

	self
		ifHorizontal: [
		handle position: self defaultMarginLength @ (widgetSize y / 2) ]
		ifVertical: [
			handle position:
				widgetSize x / 2 @ (self defaultMarginLength + barLength) ]
]

{ #category : #building }
BlDesignSlider >> rebuild [

	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ]
]

{ #category : #removing }
BlDesignSlider >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : #accessing }
BlDesignSlider >> segmented: aBoolean [ 

	segmented := aBoolean
]

{ #category : #accessing }
BlDesignSlider >> segmentedValues [

	segmentedValues ifNil: [	segmentedValues := (self minValue to: self maxValue by:
	                    self stepValue) asOrderedCollection].
	^ segmentedValues
]

{ #category : #accessing }
BlDesignSlider >> segmentedValues: aCollection [ 

	segmentedValues := aCollection 
]

{ #category : #initialization }
BlDesignSlider >> setToMax [

	"this method is created with a button that would set to max in the widget"
	self setValue: self maxValue.
]

{ #category : #initialization }
BlDesignSlider >> setToMin [ 

	"this method is created with a button that would set to max in the widget"
	self setValue: self minValue.
]

{ #category : #accessing }
BlDesignSlider >> setValue: aNumber [

	| newValue |
	newValue := aNumber.
	aNumber < self minValue ifTrue: [ newValue := minValue ].
	aNumber > self maxValue ifTrue: [ newValue := maxValue ].

	self moveHandleTo: (self valueToCoord: newValue)
]

{ #category : #'api - bounds' }
BlDesignSlider >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : #accessing }
BlDesignSlider >> stepValue [

	^ stepValue 
]

{ #category : #accessing }
BlDesignSlider >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : #'api - transformations' }
BlDesignSlider >> updateColoredBarTo: aPosition [

	self
		ifHorizontal: [
			coloredBar position: bar position.
			coloredBar size: (aPosition - coloredBar position) x @ barThickness ]
		ifVertical: [
			coloredBar position: aPosition x - (barThickness / 2) @ aPosition y.
			coloredBar size:
				barThickness @ (bar position y + barLength - aPosition y) ]
]

{ #category : #accessing }
BlDesignSlider >> value [ 

	^ value 
]

{ #category : #'api - transformations' }
BlDesignSlider >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]

{ #category : #'api - transformations' }
BlDesignSlider >> valueAtX: aPoint [

	| dist valueDiff value coeff |
	dist := (aPoint - bar position) x.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value := self nearestValue: value.
	
	^ value asFloat
]

{ #category : #'api - transformations' }
BlDesignSlider >> valueAtY: aPoint [

	| dist valueDiff value coeff |
	dist := bar position y + barLength - aPoint y.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value := self nearestValue: value.
	^ value asFloat
]

{ #category : #accessing }
BlDesignSlider >> valueLabel [

	^ valueLabel
]

{ #category : #'api - transformations' }
BlDesignSlider >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : #'api - transformations' }
BlDesignSlider >> valueToX: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ dist @ handle position y
]

{ #category : #'api - transformations' }
BlDesignSlider >> valueToY: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + barLength - (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ handle position x @ dist
]

{ #category : #accessing }
BlDesignSlider >> widgetSize [ 

	^ widgetSize 
]

{ #category : #accessing }
BlDesignSlider >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
