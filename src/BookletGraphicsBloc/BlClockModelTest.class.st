Class {
	#name : #BlClockModelTest,
	#superclass : #TestCase,
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #tests }
BlClockModelTest >> testHourCoordinate [

	| clock |
	clock := BlClockModel new.

	clock time: (Time fromString: '6:00:00').
	self assert: (clock hourCoordinate) closeTo: 0 @ 1.

	clock time: (Time fromString: '6:15:00').
	self assert: (clock hourCoordinate) closeTo: -0.1305 @ 0.9914 precision: 4.
	
	clock time: (Time fromString: '6:30:00').
	self assert: (clock hourCoordinate ) closeTo: 0.9659@(-0.2588) precision: 4.

	clock time: (Time fromString: '6:45:00').
	self assert: (clock hourCoordinate) closeTo: -0.3826 @ 0.9238 precision: 4.
]

{ #category : #tests }
BlClockModelTest >> testMinuteCoordinate [

	| clock |
	clock := BlClockModel new.

	clock time: (Time fromString: '6:00:00').
	self assert: (clock minuteCoordinate) closeTo: 0 @ -1.

	clock time: (Time fromString: '6:15:00').
	self assert: (clock minuteCoordinate) closeTo: 1 @ 0.

	clock time: ( Time fromString: '6:30:00').
	self assert: (clock minuteCoordinate) closeTo: 0 @ 1.

	clock time: (Time fromString: '6:45:00').
	self assert: (clock minuteCoordinate) closeTo: -1 @ 0
]

{ #category : #tests }
BlClockModelTest >> testSecondCoordinate [

	| clock |
	clock := BlClockModel new.

	clock time: (Time fromString: '6:00:00').
	self assert: (clock secondCoordinate) closeTo: 0 @ -1.

	clock time: (Time fromString: '6:00:15').
	self assert: (clock secondCoordinate) closeTo: 1 @ 0.

	clock time: (Time fromString: '6:00:30').
	self assert: (clock secondCoordinate) closeTo: 0 @ 1.

	clock time: (Time fromString: '6:00:45').
	self assert: (clock secondCoordinate) closeTo: -1 @ 0
]
