Class {
	#name : 'BlTaskAtQueueTest',
	#superclass : 'TestCase',
	#classTraits : 'TAssertable classTrait',
	#category : 'Bloc-Examples-Tasks',
	#package : 'Bloc-Examples',
	#tag : 'Tasks'
}

{ #category : 'running' }
BlTaskAtQueueTest >> newTaskAtQueue [
	"Answer the `BlTaskAtQueue` used for the examples.
	The queue is configured to use a simulated clock with a fixed current time for reproduceable tests."

	^ BlTaskAtQueue new
			clock:
				(BlSimulatedTime new
					date: self startTime;
					yourself);
			yourself
]

{ #category : 'running' }
BlTaskAtQueueTest >> startTime [

	^ DateAndTime fromString: '2020-11-07T12:19:53.275521+01:00'
]

{ #category : 'tests' }
BlTaskAtQueueTest >> testRunNow [
	"Queue a task that has a scheduled time in the past."

	| queue taskRun |
	queue := self newTaskAtQueue.
	taskRun := false.
	queue schedule: [ taskRun := true ] at: self startTime.
	self assert: queue size equals: 1.
	queue processNextEntry.
	self assert: taskRun
]

{ #category : 'tests' }
BlTaskAtQueueTest >> testRunOneInOneSecond [
	"Queue a task that has a scheduled time in the past."

	| queue taskRun currentTime |
	queue := self newTaskAtQueue.
	currentTime := self startTime.
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

{ #category : 'tests' }
BlTaskAtQueueTest >> testRunPastTime [
	"Queue a task that has a scheduled time in the past."

	| queue taskRun |
	queue := self newTaskAtQueue.
	taskRun := false.
	queue schedule: [ taskRun := true ] at: self startTime - 1 second.
	self assert: queue size equals: 1.
	queue processNextEntry.
	self assert: taskRun
]

{ #category : 'tests' }
BlTaskAtQueueTest >> testRunTwoOneThree [
	"Queue three tasks, out of order, and confirm correct execution."

	| queue value currentTime |
	queue := self newTaskAtQueue.
	currentTime := self startTime.
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
