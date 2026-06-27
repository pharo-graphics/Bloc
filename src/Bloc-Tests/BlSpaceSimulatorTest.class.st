Class {
	#name : #BlSpaceSimulatorTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Simulation'
}

{ #category : #tests }
BlSpaceSimulatorTest >> testDefaultTimeout [
	| aSpace simulator |
	aSpace := self newTestingSpace.
	
	simulator := aSpace simulator.
	
	self assert: simulator timeout equals: 500 milliSeconds
]

{ #category : #tests }
BlSpaceSimulatorTest >> testPulseUntilEmptyTaskQueue [
	| aSpace simulator taskRun |
	aSpace := self newTestingSpace.
	aSpace show.
	self waitTestingSpaces.
	
	taskRun := false.
	aSpace enqueueTask: (BlTaskAction new action: [ taskRun := true ]).
	
	simulator := BlSpaceSimulator forSpace: aSpace.
	simulator timeout: 500 milliSeconds.
	
	self assert: simulator pulseUntilEmptyTaskQueue.
	self assert: taskRun
]

{ #category : #tests }
BlSpaceSimulatorTest >> testPulseUntilSpaceShownAndEmptyTaskQueue [
	| aSpace simulator taskRun |
	aSpace := self newTestingSpace.
	
	taskRun := false.
	aSpace enqueueTask: (BlTaskAction new action: [ taskRun := true ]).
	
	aSpace show.
	
	simulator := BlSpaceSimulator forSpace: aSpace.
	simulator timeout: 500 milliSeconds.
	
	self assert: simulator pulseUntilSpaceShownAndEmptyTaskQueue.
	self assert: aSpace isShown.
	self assert: taskRun
]
