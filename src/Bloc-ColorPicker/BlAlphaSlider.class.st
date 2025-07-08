"
I am an Alpha Slider designed for a Color Picker.

I display a gradient of transparency on which you can select the alpha value of a Color.
My color gradient is the current color of the Color Picker.
"
Class {
	#name : #BlAlphaSlider,
	#superclass : #BlElement,
	#instVars : [
		'hueMap',
		'owner',
		'alpha',
		'cursor'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #initialization }
BlAlphaSlider class >> chessBackgroundFor: aPoint [

	^ self chessBackgroundFor: aPoint squareSize: 5
]

{ #category : #initialization }
BlAlphaSlider class >> chessBackgroundFor: aPoint squareSize: squareSize [

	| chess offset|
	offset := (aPoint x // squareSize) even ifTrue: [ 1 ] ifFalse: [ 0 ]. 
	chess := BlElement new
		         geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		         constraintsDo: [ :c |
			         c horizontal matchParent.
			         c vertical matchParent ];
		         layout:
			         (BlGridLayout horizontal columnCount:
					          aPoint x // squareSize + offset);
		         yourself.

	1 to: aPoint x // squareSize * (aPoint y // squareSize + offset) do: [ :i |
		| square |
		square := BlElement new
			          extent: squareSize asPoint;
			          background: (i even
					           ifTrue: [ Color white ]
					           ifFalse: [ Color gray ]);
			          yourself.
		chess addChild: square ].

	^ chess
]

{ #category : #accessing }
BlAlphaSlider >> alpha [ 

	^ alpha
]

{ #category : #accessing }
BlAlphaSlider >> alphaFromPosition: aPosition [

	^ aPosition x / self width
]

{ #category : #initialization }
BlAlphaSlider >> chessBackgroundFor: aPoint [ 
	^ self class chessBackgroundFor: aPoint 
]

{ #category : #accessing }
BlAlphaSlider >> clickAt: aPosition [

	| newPos |
	newPos := (aPosition x clampBetween: 0 and: self width) @ 6.

	cursor position: newPos.
	alpha := self alphaFromPosition: newPos.
	owner ifNotNil: [ :o | o updateAlpha ]
]

{ #category : #initialization }
BlAlphaSlider >> initialize [

	super initialize.
	self extent: 180 @ 12.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
	self clipChildren: false.
	self constraintsDo: [ :c | c margin: (BlInsets all: 10) ].
	alpha := 1.
	self initializeChessBackground.
	self initializeHueMap.
	self initializeCursor.
	self initializeEvents
]

{ #category : #initialization }
BlAlphaSlider >> initializeChessBackground [

	self addChild: (self chessBackgroundFor: 250 @ 12)
]

{ #category : #initialization }
BlAlphaSlider >> initializeCursor [

	cursor := BlElement new
		               extent: 20 asPoint;
		               background: Color transparent;
		               geometry: BlCircleGeometry new;
		               border: (BlBorder paint: Color white width: 2);
		               constraintsDo: [ :c | c ignoredByLayout ];
		               yourself.

	self whenLayoutedDoOnce: [
		cursor position: self width @ (self height / 2) ].


	cursor transformDo: [ :t | t translateBy: -10 asPoint ].

	self addChild: cursor
]

{ #category : #initialization }
BlAlphaSlider >> initializeEvents [

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
BlAlphaSlider >> initializeHueMap [

	hueMap := BlElement new
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		          constraintsDo: [ :c |
			          c horizontal matchParent.
			          c vertical matchParent.
						c ignoredByLayout ].
	hueMap background: (BlLinearGradientPaint horizontal stops: {
				 (0 -> Color transparent).
				 (1 -> Color red) }).

	self addChild: hueMap
]

{ #category : #accessing }
BlAlphaSlider >> owner: anElement [

	owner := anElement 
]

{ #category : #accessing }
BlAlphaSlider >> setColor: newColor [

	hueMap background: (BlLinearGradientPaint horizontal stops: {
				 (0 -> Color transparent).
				 (1 -> newColor) })
]
