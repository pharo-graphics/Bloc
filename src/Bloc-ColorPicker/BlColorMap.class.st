Class {
	#name : #BlColorMap,
	#superclass : #BlElement,
	#instVars : [
		'colorCircle',
		'saturationMap',
		'brightnessMap',
		'saturation',
		'brightness',
		'hue',
		'color',
		'owner'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #accessing }
BlColorMap >> clickAt: aPosition [

	| newPos |
	newPos := (aPosition x clampBetween: 0 and: self width)
	          @ (aPosition y clampBetween: 0 and: self height).

	colorCircle position: newPos.

	saturation := newPos x / self width.
	brightness := 1 - (newPos y / self height).
	color := (Color h: hue s: saturation v: brightness).
	colorCircle background: color.
	self owner ifNotNil: [ :o | o updateColor ].
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
	saturation := 0.
	brightness := 1.
	self initializeSaturationMap.
	self initializeBrightnessMap.
	self initializeColorCircle.
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
BlColorMap >> initializeColorCircle [

	colorCircle := BlElement new size: 20 asPoint; background: Color white; geometry: BlCircleGeometry new; border: (BlBorder paint: Color white width: 2 ).
	
	colorCircle transformDo: [ :t | t translateBy: -10 asPoint ].
	
	self addChild: colorCircle.
	
	
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
BlColorMap >> owner [ 

	^ owner
]

{ #category : #'children accessing' }
BlColorMap >> owner: anElement [

	owner := anElement 
]

{ #category : #initialization }
BlColorMap >> setHue: newHue [

	hue := newHue.
	color := (Color h: hue s: 1 v: 1).

	saturationMap background: (BlLinearGradientPaint horizontal stops: {
				 (0 -> Color white).
				 (1 -> color) }).

	colorCircle background: (Color h: hue s: saturation v: brightness)
]
