"
I am an example of an analog clock element
"
Class {
	#name : #BlClockExample,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-Animation'
}

{ #category : #examples }
BlClockExample class >> clock [
	<script: 'self clock'>
	
	self
		openInWindow: self new animatedClock
		named: 'Clock'
		extent: 400@400
]

{ #category : #'examples - clock' }
BlClockExample >> animatedClock [
	<gtExample>
	| secondHand animation |

	secondHand := self secondHand.
	
	animation := BlNumberTransition new
		onStepDo: [ :aSecond |
			secondHand transformDo: [ :aTransform |
				aTransform rotateBy: aSecond * self minuteRotationDelta - 90 ] ];
		from: 0;
		to: 60;
		by: 1;
		loops: 1;
		duration: 60 seconds.
		
	secondHand addAnimation: animation.

	^ self clock
		relocate: 50@50;
		addChildren: self hourTicks;
		addChildren: self minuteTicks;
		addChild: secondHand
]

{ #category : #'instance creation - clock' }
BlClockExample >> clock [
	<gtExample>

	^ BlElement new
		geometry: BlEllipse new;
		border: (BlBorder paint: Color black width: 1);
		layout: BlFrameLayout new;
		size: self radius asPoint * 2
]

{ #category : #'instance creation - hand' }
BlClockExample >> hand [
	<gtExample>

	^ BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal exact: 200.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		yourself
]

{ #category : #'instance creation - hand' }
BlClockExample >> handDot [
	<gtExample>

	^ BlElement new
		background: Color red;
		size: 15@15;
		geometry: BlEllipse new;
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignRight ];
		yourself
]

{ #category : #'instance creation - hand' }
BlClockExample >> handLine [
	<gtExample>

	^ BlLineElement new
		border: (BlBorder paint: Color red width: 1)
]

{ #category : #parameters }
BlClockExample >> handOffset [
	^ self padding + self hourTickLength + 5
]

{ #category : #'instance creation - hand' }
BlClockExample >> handStart [
	<gtExample>

	^ BlElement new
		size: 0@0;
		constraintsDo: [ :c | c frame vertical alignCenter ]
]

{ #category : #parameters }
BlClockExample >> hourRotationDelta [
	<gtExample>

	^ 360 / 12
]

{ #category : #'instance creation - ticks' }
BlClockExample >> hourTick [
	<gtExample>
	
	^ self tick
		background: Color black;
		size: self hourTickLength @ self hourTickBreadth
]

{ #category : #'instance creation - ticks' }
BlClockExample >> hourTickAt: anHour [
	<gtExample>
	
	^ self hourTick
		relocate: ((2 * self radius) - self hourTickLength - self padding) @ (self radius - (self hourTickBreadth / 2.0));
		transformDo: [ :aTransform |
			aTransform
				origin: (BlAffineTransformationPositionOrigin position: (self radius negated + self hourTickLength + self padding) @ (self hourTickBreadth / 2.0));
				rotateBy: (anHour - 1) * self hourRotationDelta ];
		yourself
]

{ #category : #parameters }
BlClockExample >> hourTickBreadth [
	^ 5
]

{ #category : #parameters }
BlClockExample >> hourTickLength [
	^ 30
]

{ #category : #'instance creation - ticks' }
BlClockExample >> hourTicks [
	<gtExample>
	
	^ 12 timesCollect: [ :anHour | self hourTickAt: anHour ]
]

{ #category : #parameters }
BlClockExample >> minuteRotationDelta [
	<gtExample>

	^ 360 / 60
]

{ #category : #'instance creation - ticks' }
BlClockExample >> minuteTick [
	<gtExample>

	^ self tick
		background: Color black;
		size: self minuteTickLength @ self minuteTickBreadth
]

{ #category : #'instance creation - ticks' }
BlClockExample >> minuteTickAt: aMinute [
	<gtExample>
	
	^ self minuteTick
		in: [ :aMinuteTick | (aMinute - 1) % 5 = 0 ifTrue: [ aMinuteTick visibility: BlVisibility gone  ] ];
		relocate: ((2 * self radius) - self minuteTickLength - self padding) @ (self radius - (self minuteTickBreadth / 2.0));
		transformDo: [ :aTransform |
			aTransform
				origin: (BlAffineTransformationPositionOrigin position: (self radius negated + self minuteTickLength + self padding) @ (self minuteTickBreadth / 2.0));
				rotateBy: (aMinute - 1) * self minuteRotationDelta ];
		yourself
]

{ #category : #parameters }
BlClockExample >> minuteTickBreadth [
	^ 4
]

{ #category : #parameters }
BlClockExample >> minuteTickLength [
	^ 10
]

{ #category : #'instance creation - ticks' }
BlClockExample >> minuteTicks [
	<gtExample>

	^ 60 timesCollect: [ :anHour | self minuteTickAt: anHour ]
]

{ #category : #parameters }
BlClockExample >> padding [
	^ 10
]

{ #category : #parameters }
BlClockExample >> radius [
	^ 150
]

{ #category : #'instance creation - hand' }
BlClockExample >> secondHand [
	<gtExample>
	| handStart handDot handLine |
	
	handStart := self handStart.
	handStart relocate: (self secondHandLength - self handOffset - self handOffset) @ 0.
	
	handDot := self handDot.
	
	handLine := self handLine.
	handLine fromAnchor: (BlElementCenterAnchor element: handStart).
	handLine toAnchor: (BlElementCenterAnchor element: handDot).
	
	^ self hand
		constraintsDo: [ :c |
			c horizontal exact: (self secondHandLength - self handOffset) * 2.
			c vertical fitContent ];
		addChildren: { handStart . handDot . handLine };
		yourself
]

{ #category : #parameters }
BlClockExample >> secondHandLength [
	^ self radius
]

{ #category : #'instance creation - ticks' }
BlClockExample >> tick [
	<gtExample>

	^ BlElement new
		constraintsDo: [ :c |
			c ignoreByLayout ];
		background: Color black
]
