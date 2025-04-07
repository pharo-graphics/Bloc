Class {
	#name : #BlColorSlider,
	#superclass : #BlElement,
	#instVars : [
		'colorCircle',
		'hue',
		'owner'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #accessing }
BlColorSlider >> clickAt: aPosition [

	| newPos |
	newPos := (aPosition x clampBetween: 0 and: self width) @ 6.

	colorCircle position: newPos.
	hue := self hueFromPosition: newPos.
	colorCircle background: (Color h: hue s: 1 v: 1).
	self owner ifNotNil: [ :o | o updateHue ].
]

{ #category : #accessing }
BlColorSlider >> hue [ 

	^ hue
]

{ #category : #hooks }
BlColorSlider >> hueFromPosition: aPosition [

	^ (aPosition x * 360 / self width) floor
]

{ #category : #initialization }
BlColorSlider >> initialize [

	super initialize.
	self size: 180 @ 12.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
	self clipChildren: false.
	self constraintsDo: [ :c | c margin: (BlInsets all: 10) ].
	self initializeHues.
	self initializeColorCircle.
	self initializeEvents
]

{ #category : #initialization }
BlColorSlider >> initializeColorCircle [

	colorCircle := BlElement new
		               size: 20 asPoint;
		               background: Color red;
		               geometry: BlCircleGeometry new;
		               border: (BlBorder paint: Color white width: 2); yourself.
	self whenLayoutedDoOnce: [ colorCircle position: 0 @ (self height / 2) ].	
	

	colorCircle transformDo: [ :t | t translateBy: -10 asPoint ].

	self addChild: colorCircle
]

{ #category : #initialization }
BlColorSlider >> initializeEvents [

	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consume.
		self clickAt: e localPosition ].

	self addEventHandlerOn: BlMouseDownEvent do: [ :e |
		e consume.
		self clickAt: e localPosition ].

	self addEventHandlerOn: BlDragStartEvent do: [ :e |
		e consume.
		self clickAt: e localPosition ].

	self addEventHandlerOn: BlDragEvent do: [ :e |
		e consume.
		self clickAt: e localPosition ]
]

{ #category : #initialization }
BlColorSlider >> initializeHues [ 

	| maxHueValue hues paint |
	maxHueValue := 360.
    hues := OrderedCollection new.
    0 to: 1 by: 0.1 do: [ :step |
        hues add: step -> (Color h: step * maxHueValue s: 1 v: 1) ].

    paint := (LinearGradientPaint fromArray: hues)
          yourself.

	self background: (BlLinearGradientPaint horizontal stops: paint colorRamp).
]

{ #category : #accessing }
BlColorSlider >> owner [ 

	^ owner 
]

{ #category : #accessing }
BlColorSlider >> owner: anElement [ 

	owner := anElement 
]
