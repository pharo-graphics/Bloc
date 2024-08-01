"
A clock implementation using only Bloc graphic framework

See class side for usage with 
- fixed size
- dynamic layout
"
Class {
	#name : #BlClock,
	#superclass : #BlElement,
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
BlClock class >> openInDynamicLayout [

	<sampleInstance>
	| clock space |
	space := BlSpace new.

	space root
		border: (BlBorder paint: Color red width: 1);
		background: Color yellow;
		layout: BlFlowLayout horizontal.


	clock := self new constraintsDo: [ :c |
		         c horizontal matchParent.
		         c vertical matchParent ].

	space root addChild: clock.
	space show.
	^ clock
]

{ #category : #example }
BlClock class >> openInFixedSize [

	<sampleInstance>
	| clock container |
	container := BlElement new
		             border: (BlBorder paint: Color red width: 1);
		             background: Color yellow;
		             layout: BlFrameLayout new;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	clock := self new size: 300 @ 300.

	container addChild: clock.

	container openInNewSpace.
	^ clock
]

{ #category : #'api - look' }
BlClock >> background [

	^ BlBackground  paint: Color lightGray
]

{ #category : #'api - look' }
BlClock >> border [

	^ BlBorder paint: Color black width: 4
]

{ #category : #'api - look' }
BlClock >> geometry [

	^ BlCircleGeometry new matchExtent: self extent.
]

{ #category : #initialization }
BlClock >> initAnimation [

	| animation |
	animation := BlAnimation new
		             beInfinite;
		             duration: 0.5 seconds.

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent |
				 model time: Time now.
				self updateNeedlesPosition.
				 self invalidate ]).

	self addAnimation: animation
]

{ #category : #initialization }
BlClock >> initClock [
	self removeChildren.

	self initConstant.
	self initClockFrame.
	self initElements.
	self initAnimation
]

{ #category : #initialization }
BlClock >> initClockFrame [
	"draw small lines around clock frame"

	| quarterLength quarterWidth hourLength hourWidth |
	quarterLength := radius * 4.8 /20.
	quarterWidth := 8.
	hourLength := radius * 3.2 /20.
	hourWidth := 6.

	0 to: 11 do: [ :items |
		| coordinate angle |
		angle := items * Float pi / 6.
		coordinate := angle cos @ angle sin.

		items % 3 == 0
			ifTrue: [ "quarter mark"
				self addChild: (BlElement new
						 geometry: (BlLineGeometry
								  from: center + (coordinate * (radius - quarterLength))
								  to: center + (coordinate * radius));
						 outskirts: BlOutskirts centered;
						 border: (BlBorder paint: Color black width: quarterWidth)) ]
			ifFalse: [ "other hour marks"
				self addChild: (BlElement new
						 geometry: (BlLineGeometry
								  from: center + (coordinate * (radius - hourLength))
								  to: center + (coordinate * radius));
						 outskirts: BlOutskirts centered;
						 border: (BlBorder paint: Color black width: hourWidth)) ] ]
]

{ #category : #initialization }
BlClock >> initConstant [

	center := radius @ radius.
	hourNeedleSize := radius / 2.
	minuteNeedleSize := radius * 14.8 / 20.
	secondNeedleSize := radius * 16.8 / 20
]

{ #category : #initialization }
BlClock >> initElements [

	hourNeedle := BlElement new
		              id: #hourNeedle;
		              geometry: BlLineGeometry new;
		              outskirts: BlOutskirts centered;
		              border: (BlBorder paint: Color black width: 5).

	minutesNeedle := BlElement new
		                 id: #minuteNeedle;
		                 geometry: BlLineGeometry new;
		                 outskirts: BlOutskirts centered;
		                 border: (BlBorder paint: Color black width: 5).

	secondNeedle := BlElement new
		                id: #secondNeedle;
		                geometry: BlLineGeometry new;
		                outskirts: BlOutskirts centered;
		                border: (BlBorder paint: Color red width: 3).

	self addChildren: {
			hourNeedle.
			minutesNeedle.
			secondNeedle }
]

{ #category : #initialization }
BlClock >> initialize [

	super initialize.
	model := BlClockModel new.
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :e | self resize ]
]

{ #category : #'as yet unclassified' }
BlClock >> resize [

	radius := self extent min / 2.0.
	self initClock
]

{ #category : #'api - bounds' }
BlClock >> size: aPoint [
	super size: aPoint.

	radius := aPoint x / 2.
	self initClock.
]

{ #category : #positioning }
BlClock >> updateHourNeedlePosition [

	| coordinate |
	coordinate := model  hourCoordinate.
	hourNeedle geometry from: center to: center + (coordinate * hourNeedleSize).

]

{ #category : #positioning }
BlClock >> updateMinuteNeedlePosition [

	| coordinate |
	coordinate := model  minuteCoordinate.
	minutesNeedle geometry from: center to: center + (coordinate * minuteNeedleSize)
]

{ #category : #positioning }
BlClock >> updateNeedlesPosition [

	self updateHourNeedlePosition.
	self updateMinuteNeedlePosition.
	self updateSecondNeedlePosition.
]

{ #category : #positioning }
BlClock >> updateSecondNeedlePosition [

	| coordinate |
	coordinate :=  model secondCoordinate.
	secondNeedle geometry
		from: center
		to: center + (coordinate * secondNeedleSize)
]
