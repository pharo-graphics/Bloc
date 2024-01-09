Class {
	#name : #BlTaskAtQueueExamples,
	#superclass : #TestCase,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Bloc-Examples-Tasks'
}

{ #category : #private }
BlTaskAtQueueExamples >> startTime [

	^ DateAndTime fromString: '2020-11-07T12:19:53.275521+01:00'
]

{ #category : #private }
BlTaskAtQueueExamples >> taskAtQueue [
	"Answer the BlTaskAtQueue used for the examples.
	The queue is configured to use a simulated clock with a fixed current time for reproduceable tests."

	^ BlTaskAtQueue new 
		clock: (BlSimulatedTime new 
			date: self startTime)
]

{ #category : #examples }
BlTaskAtQueueExamples >> testRunNow [
	"Queue a task that has a scheduled time in the past."

	| queue taskRun |
	queue := self taskAtQueue.
	taskRun := false.
	queue schedule: [ taskRun := true ] at: self startTime.
	self assert: queue size equals: 1.
	queue processNextEntry.
	self assert: taskRun
]

{ #category : #examples }
BlTaskAtQueueExamples >> testRunOneInOneSecond [
	"Queue a task that has a scheduled time in the past."

	| queue taskRun currentTime |
	currentTime := self startTime.
	queue := self taskAtQueue.
	taskRun := false.
	queue schedule: [ taskRun := true ] at: self startTime + 1 second.
	self assert: queue size equals: 1.
	queue processNextEntry.
	self deny: taskRun.
	self assert: queue size equals: 1.
	queue clock date: (currentTime := currentTime + 1 second).
	queue forceProcess.
	queue processNextEntry.
	self assert: taskRun
]

{ #category : #examples }
BlTaskAtQueueExamples >> testRunPastTime [
	"Queue a task that has a scheduled time in the past."

	| queue taskRun |
	queue := self taskAtQueue.
	taskRun := false.
	queue schedule: [ taskRun := true ] at: self startTime - 1 second.
	self assert: queue size equals: 1.
	queue processNextEntry.
	self assert: taskRun
]

{ #category : #examples }
BlTaskAtQueueExamples >> testRunTwoOneThree [
	"Queue three tasks, out of order, and confirm correct execution."

	| queue value currentTime |
	currentTime := self startTime.
	queue := self taskAtQueue.
	value := 0.
	queue schedule: [ value := 2 ] at: self startTime + 2 second.
	queue schedule: [ value := 1 ] at: self startTime + 1 second.
	queue schedule: [ value := 3 ] at: self startTime + 3 second.
	self assert: queue size equals: 3.
	queue processNextEntry.
	self assert: value equals: 0.
	queue clock date: (currentTime := currentTime + 1 second).
	queue forceProcess.
	queue processNextEntry.
	self assert: value equals: 1.
	self assert: queue size equals: 2.
	queue clock date: (currentTime := currentTime + 1 second).
	queue forceProcess.
	queue processNextEntry.
	self assert: value equals: 2.
	self assert: queue size equals: 1.
	queue clock date: (currentTime := currentTime + 1 second).
	queue forceProcess.
	queue processNextEntry.
	self assert: value equals: 3.
	self assert: queue size equals: 0
]
