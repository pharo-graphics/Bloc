"
I am a Color Slider designed for a Color Picker.

I display a range of hues you can select with my cursor. 
The selected hue changes the hue of the Color Map contained in the Color Picker.
"
Class {
	#name : #BlColorSlider,
	#superclass : #BlElement,
	#instVars : [
		'hue',
		'owner',
		'cursor'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #accessing }
BlColorSlider >> clickAt: aPosition [

	| newPos |
	newPos := (aPosition x clampBetween: 0 and: self width) @ 6.

	cursor position: newPos.
	hue := self hueFromPosition: newPos.
	cursor background: (Color h: hue s: 1 v: 1).
	owner ifNotNil: [ :o | o updateHue ]
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
	self initializeCursor.
	self initializeEvents
]

{ #category : #initialization }
BlColorSlider >> initializeCursor [

	cursor := BlElement new
		               size: 20 asPoint;
		               background: Color red;
		               geometry: BlCircleGeometry new;
		               border: (BlBorder paint: Color white width: 2); yourself.
	self whenLayoutedDoOnce: [ cursor position: 0 @ (self height / 2) ].	
	

	cursor transformDo: [ :t | t translateBy: -10 asPoint ].

	self addChild: cursor
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
BlColorSlider >> owner: anElement [ 

	owner := anElement 
]

{ #category : #hooks }
BlColorSlider >> positionFromHue: aHue [

	^ aHue * self width / 360 @ (self height / 2)
]

{ #category : #updating }
BlColorSlider >> updateCursor [

	cursor position: (self positionFromHue: owner color hue).
	cursor background: (Color h: owner color hue s: 1 v: 1).
]
