Class {
	#name : #BlTktExamplesSignaler,
	#superclass : #Object,
	#instVars : [
		'taskSemaphore',
		'callerSemaphore'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #defaults }
BlTktExamplesSignaler >> defaultTimeout [
	^ 1000 "milliSeconds"
]

{ #category : #initialization }
BlTktExamplesSignaler >> initialize [
	super initialize.
	callerSemaphore := Semaphore new.
	taskSemaphore := Semaphore new.
]

{ #category : #signalling }
BlTktExamplesSignaler >> signalCallerSemaphore [
	callerSemaphore signal
]

{ #category : #signalling }
BlTktExamplesSignaler >> signalTaskSemaphore [
	taskSemaphore signal
]

{ #category : #signalling }
BlTktExamplesSignaler >> waitForCaller [
	callerSemaphore waitTimeoutMSecs: self defaultTimeout
]

{ #category : #signalling }
BlTktExamplesSignaler >> waitForTask [
	taskSemaphore waitTimeoutMSecs: self defaultTimeout
]
