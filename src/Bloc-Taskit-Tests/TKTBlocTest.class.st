Class {
	#name : #TKTBlocTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Taskit-Tests'
}

{ #category : #running }
TKTBlocTest >> isBeingExecutedInTaskPhase [

	^ thisContext stack anySatisfy: [ :each |
		  each receiver class = BlSpaceFrameTaskPhase ]
]

{ #category : #tests }
TKTBlocTest >> testRunner [

	| space runner |
	space := self newTestingSpace.
	space root background: Color green.

	runner := TKTBlSpaceRunner on: space.
	runner schedule: [
		space root background: Color red.
		self assert: self isBeingExecutedInTaskPhase ] asTask.

	"Task is not executed immediately"
	self
		assert: space root background paint color
		equals: Color green.
	"Check again after pulse"
	self waitTestingSpaces.
	self
		assert: space root background paint color
		equals: Color red
]

{ #category : #tests }
TKTBlocTest >> testService [

	| space service count |
	space := self newTestingSpace.
	space show.

	service := TKTBlSpaceService on: space.
	count := 0.
	service step: [
		count := count + 1.
		self assert: self isBeingExecutedInTaskPhase ].
	service stepDelay: 50 milliSeconds.
	service start.

	0.5 seconds wait.
	service stop waitForCompletion: 1 second.
	
	self assert: count > 1
]
