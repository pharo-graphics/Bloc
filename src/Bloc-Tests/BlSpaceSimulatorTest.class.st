Class {
	#name : #BlSpaceSimulatorTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Simulation'
}

{ #category : #tests }
BlSpaceSimulatorTest >> testDefaultTimeout [
	| aSpace eventSimulator |
	aSpace := self newTestingSpace.
	
	eventSimulator := aSpace eventSimulator.
	
	self assert: eventSimulator timeout equals: 500 milliSeconds
]

{ #category : #tests }
BlSpaceSimulatorTest >> testPulseUntilEmptyTaskQueue [
	| aSpace eventSimulator taskRun |
	aSpace := self newTestingSpace.
	aSpace show.
	self waitTestingSpaces.
	
	taskRun := false.
	aSpace enqueueTask: (BlTaskAction new action: [ taskRun := true ]).
	
	eventSimulator := BlSpaceSimulator forSpace: aSpace.
	eventSimulator timeout: 500 milliSeconds.
	
	self assert: eventSimulator pulseUntilEmptyTaskQueue.
	self assert: taskRun
]

{ #category : #tests }
BlSpaceSimulatorTest >> testPulseUntilSpaceShownAndEmptyTaskQueue [
	| aSpace eventSimulator taskRun |
	aSpace := self newTestingSpace.
	
	taskRun := false.
	aSpace enqueueTask: (BlTaskAction new action: [ taskRun := true ]).
	
	aSpace show.
	
	eventSimulator := BlSpaceSimulator forSpace: aSpace.
	eventSimulator timeout: 500 milliSeconds.
	
	self assert: eventSimulator pulseUntilSpaceShownAndEmptyTaskQueue.
	self assert: aSpace isShown.
	self assert: taskRun
]
