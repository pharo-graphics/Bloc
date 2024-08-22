"
A clock implementation using Bloc graphic framework and facilities with Toplo

See class side for usage with 
- fixed size
- dynamic layout
"
Class {
	#name : #ToClock,
	#superclass : #ToElement,
	#instVars : [
		'hourNeedle',
		'minutesNeedle',
		'secondNeedle',
		'center',
		'radius',
		'hourNeedleSize',
		'minuteNeedleSize',
		'secondNeedleSize',
		'model'
	],
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #example }
ToClock class >> openInDynamicLayout [

	<sampleInstance>
	| clock space |
	space := BlSpace new.
	space toTheme: ToRawClockTheme new.

	space root
		border: (BlBorder paint: Color red width: 1);
		background: Color white;
		layout: BlFlowLayout horizontal.


	clock := self new constraintsDo: [ :c |
		         c horizontal matchParent.
		         c vertical matchParent ].

	space root addChild: clock.
	space show.
	^ clock
]

{ #category : #example }
ToClock class >> openInDynamicLayoutWithStyleSheet [

	<sampleInstance>
	| clock space |
	space := BlSpace new.
	space toTheme: ToClockStyleSheetTheme new.

	space root
		border: (BlBorder paint: Color red width: 1);
		background: Color white;
		layout: BlFlowLayout horizontal.


	clock := self new constraintsDo: [ :c |
		         c horizontal matchParent.
		         c vertical matchParent ].

	space root addChild: clock.
	space show.
	^ clock
]

{ #category : #example }
ToClock class >> openInFixedSize [

	<sampleInstance>
	| clock container space |
	space := BlSpace new.
	space toTheme: ToRawClockTheme new.
	
	container := BlElement new
		             border: (BlBorder paint: Color red width: 1);
		             background: Color white ;
		             layout: BlFrameLayout new;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	clock := self new size: 300 @ 300.

	container addChild: clock.

	space root addChild: container.
	space show.
	^ container.
]

{ #category : #example }
ToClock class >> openInFixedSizeWithStyleSheet [

	<sampleInstance>
	| clock container space |
	space := BlSpace new.
	space toTheme: ToClockStyleSheetTheme new.
	
	container := BlElement new
		             border: (BlBorder paint: Color red width: 1);
		             background: Color white ;
		             layout: BlFrameLayout new;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	clock := self new size: 300 @ 300.

	container addChild: clock.

	space root addChild: container.
	space show.
	^ container.
]

{ #category : #accessing }
ToClock >> center [

	^ center
]

{ #category : #accessing }
ToClock >> hourNeedle [

	^ hourNeedle
]

{ #category : #initialization }
ToClock >> initAnimation [

	| animation |
	animation := BlAnimation new
		             beInfinite;
		             duration: 0.5 seconds.

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent | 
					model time: Time now.
					self updateNeedlesPosition.
					self invalidate .]).

	self addAnimation: animation
]

{ #category : #initialization }
ToClock >> initClock [
	self removeChildren.

	self initConstant.
	self initElements.
	self requestNewSkin.
	self initAnimation
	"self whenLayoutedDoOnce:  [ self initAnimation ]."
]

{ #category : #initialization }
ToClock >> initConstant [

	center := radius @ radius.
	hourNeedleSize := radius / 2.
	minuteNeedleSize := radius * 14.8 / 20.
	secondNeedleSize := radius * 16.8 / 20
]

{ #category : #initialization }
ToClock >> initElements [

	secondNeedle := ToElement new id: #secondNeedle.
	minutesNeedle := ToElement new id: #minuteNeedle.
	hourNeedle := ToElement new id: #hourNeedle.

	self addChildren: {
			hourNeedle.
			minutesNeedle.
			secondNeedle }
]

{ #category : #initialization }
ToClock >> initialize [

	super initialize.
	model := BlClockModel new.
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :e | self resize ].
	self resize.
]

{ #category : #skin }
ToClock >> installRawStyle [

	super installRawStyle.
]

{ #category : #accessing }
ToClock >> minutesNeedle [

	^ minutesNeedle
]

{ #category : #skin }
ToClock >> newRawSkin [

	^ ToClockSkin new
]

{ #category : #'api - bounds' }
ToClock >> resize [

	radius := self extent min / 2.0.
	self initClock.
	

	
]

{ #category : #accessing }
ToClock >> secondNeedle [

	^ secondNeedle
]

{ #category : #'api - bounds' }
ToClock >> size: aPoint [

	super size: aPoint.
	radius := aPoint x / 2.
	self initClock
]

{ #category : #positioning }
ToClock >> updateHourNeedlePosition [

	| coordinate |
	coordinate := model hourCoordinate.
	hourNeedle geometry
		from: center
		to: center + (coordinate * hourNeedleSize)
]

{ #category : #positioning }
ToClock >> updateMinuteNeedlePosition [

	| coordinate |
	coordinate := model minuteCoordinate.
	minutesNeedle geometry
		from: center
		to: center + (coordinate * minuteNeedleSize)
]

{ #category : #positioning }
ToClock >> updateNeedlesPosition [

	self updateHourNeedlePosition.
	self updateMinuteNeedlePosition.
	self updateSecondNeedlePosition.
]

{ #category : #positioning }
ToClock >> updateSecondNeedlePosition [

	| coordinate |
	coordinate := model  secondCoordinate.
	secondNeedle geometry
		from: center
		to: center + (coordinate * secondNeedleSize)
]
