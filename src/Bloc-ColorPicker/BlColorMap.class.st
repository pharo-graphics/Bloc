"
I am a Color Map designed for a Color Picker.

I present a rectangle of gradients for a certain hue, according to its saturation and brightness.

I have a cursor that modifies the values of saturation and brightness of the current color.
My hue can be modified according to the Color Slider and/or the Color Palette of the Color Picker.
"
Class {
	#name : #BlColorMap,
	#superclass : #BlElement,
	#instVars : [
		'saturationMap',
		'brightnessMap',
		'saturation',
		'brightness',
		'hue',
		'color',
		'owner',
		'cursor'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #accessing }
BlColorMap >> clickAt: aPosition [

	| newPos |
	newPos := (aPosition x clampBetween: 0 and: self width)
	          @ (aPosition y clampBetween: 0 and: self height).

	cursor position: newPos.

	saturation := newPos x / self width.
	brightness := 1 - (newPos y / self height).
	color := Color h: hue s: saturation v: brightness.
	cursor background: color.
	owner ifNotNil: [ :o | o updateColor ]
]

{ #category : #accessing }
BlColorMap >> color [ 

	^ color
]

{ #category : #initialization }
BlColorMap >> initialize [

	super initialize.
	self size: 250 @ 140.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
	self clipChildren: false.
	self constraintsDo: [ :c | c margin: (BlInsets all: 10) ].
	hue := 0.
	saturation := 1.
	brightness := 1.
	self initializeSaturationMap.
	self initializeBrightnessMap.
	self initializeCursor.
	self initializeEvents
]

{ #category : #initialization }
BlColorMap >> initializeBrightnessMap [ 

	brightnessMap := BlElement new geometry: (BlRoundedRectangleGeometry cornerRadius: 10) ;constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent. ].
	brightnessMap background: (BlLinearGradientPaint vertical stops: {
						         (0 -> Color transparent).
						         (1 -> Color black) }).
	
	self addChild: brightnessMap 
]

{ #category : #initialization }
BlColorMap >> initializeCursor [

	cursor := BlElement new
		               size: 20 asPoint;
		               background: Color red;
		               geometry: BlCircleGeometry new;
		               border: (BlBorder paint: Color white width: 2).

	cursor transformDo: [ :t | t translateBy: -10 asPoint ].
	self whenLayoutedDoOnce: [ cursor position: self width @ 0 ].

	self addChild: cursor
]

{ #category : #initialization }
BlColorMap >> initializeEvents [

	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consume.
		self clickAt: e localPosition. ].
	
	self addEventHandlerOn: BlMouseDownEvent do: [ :e |
		e consume.
		self clickAt: e localPosition. ].

	self addEventHandlerOn: BlDragStartEvent do: [ :e |
		e consume.
		self clickAt: e localPosition. ].
	
	self addEventHandlerOn: BlDragEvent do: [ :e |
		e consume.
		self clickAt: e localPosition. ].
]

{ #category : #initialization }
BlColorMap >> initializeSaturationMap [ 

	saturationMap := BlElement new geometry: (BlRoundedRectangleGeometry cornerRadius: 10) ;constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent. ].
	saturationMap background: (BlLinearGradientPaint horizontal stops: {
						         (0 -> Color white).
						         (1 -> Color red) }).
	
	self addChild: saturationMap 
]

{ #category : #'children accessing' }
BlColorMap >> owner: anElement [

	owner := anElement 
]

{ #category : #updating }
BlColorMap >> positionCursor [

	| newX newY |
	newX := saturation * self width.
	newY := 1 - brightness * self height.
	cursor position: newX @ newY.
	owner updateSliderCursor.
]

{ #category : #accessing }
BlColorMap >> setColor: aColor [

	saturation := aColor saturation.
	brightness := aColor brightness.
	self setHue: aColor hue.
	owner updateColor.
	self positionCursor
]

{ #category : #accessing }
BlColorMap >> setHue: newHue [

	hue := newHue.
	color := Color h: hue s: saturation v: brightness.

	saturationMap background: (BlLinearGradientPaint horizontal stops: {
				 (0 -> Color white).
				 (1 -> (Color h: hue s:1 v: 1)) }).

	cursor background: color
]
