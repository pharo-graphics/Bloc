"
A clock implementation using only Bloc graphic framework

See class side for usage with 
- fixed size
- dynamic layout
"
Class {
	#name : #BlClockModel,
	#superclass : #Object,
	#instVars : [
		'time'
	],
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #example }
BlClockModel class >> openInDynamicLayout [

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
BlClockModel class >> openInFixedSize [

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

{ #category : #positioning }
BlClockModel >> hourCoordinate [

	| angleHours y angleTime  angleMinutes x |
	angleHours := Float pi / 6 * time hours.
	angleMinutes := Float pi / 360 * time minutes.
	angleTime := angleHours + angleMinutes.

	x := angleTime sin.
	y := angleTime cos * -1.

	^ 	x @ y.
]

{ #category : #positioning }
BlClockModel >> minuteCoordinate [

	| x y angle |
	angle := Float pi / 30 * time minutes.
	x := angle sin.
	y := angle cos * -1.
	^ x @ y.
]

{ #category : #positioning }
BlClockModel >> secondCoordinate [

	| x y angle  |
	angle := Float pi / 30 * time seconds.
	x := angle sin.
	y := angle cos * -1.
	^ x @ y.
]

{ #category : #accessing }
BlClockModel >> time: anObject [

	time := anObject
]
