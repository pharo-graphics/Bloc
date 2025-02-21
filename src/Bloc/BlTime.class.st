"
I encapsulate a concept of time and play a role of a time provider for Animations or other parts of the system that compute durations or how much time passed since some action.

Bloc components must not directly rely on system time or hardcode it in any place because it prevents us from simulating spaces. I am what makes the system exemplifiable.

"
Class {
	#name : #BlTime,
	#superclass : #Object,
	#instVars : [
		'frozenTime',
		'frozen'
	],
	#category : #'Bloc-Universe'
}

{ #category : #'instance creation' }
BlTime class >> fastForwarded [
	^ BlFastForwardedTime new
]

{ #category : #'instance creation' }
BlTime class >> real [
	^ BlRealTime new
]

{ #category : #'instance creation' }
BlTime class >> simulated [
	^ BlSimulatedTime new
]

{ #category : #'private - time' }
BlTime >> currentTime [
	^ self subclassResponsibility
]

{ #category : #'private - time' }
BlTime >> currentUTCMicroseconds [

	^ self currentTime utcMicroSeconds 
]

{ #category : #'api - enumeration' }
BlTime >> every: aDuration during: aLoopDuration do: aDoBlock [
	| aStartTime |
	
	aStartTime := self now.

	self
		every: aDuration
		while: [ self now < (aStartTime + aLoopDuration) ]
		do: aDoBlock
]

{ #category : #'api - enumeration' }
BlTime >> every: aDuration times: aCountOfRepeats do: aDoBlock [
	"Evaluate a aDoBlock a given amount of times waiting a provided amount of time between executions.
	The first evaluation of a aDoBlock is instant.
	Note: evaluation is synchronous"
	| aCounter |
	
	aCounter := 0.
	self
		every: aDuration
		while: [ (aCounter := aCounter + 1) <= aCountOfRepeats ]
		do: aDoBlock
]

{ #category : #'api - enumeration' }
BlTime >> every: aDuration while: aWhileBlock do: aDoBlock [
	"Evaluate a aDoBlock while aWhileBlock evaluates to true waiting a given amount of time between executions.
	The first evaluation of a aDoBlock is instant.
	Note: evaluation is synchronous"
	
	self subclassResponsibility
]

{ #category : #initialization }
BlTime >> initialize [
	super initialize.
	
	frozen := false
]

{ #category : #'api - time' }
BlTime >> now [
	"Return a 'current' date and time, it is not necessarily a real one"
	<return: #DateAndTime>

	^ frozen
		ifTrue: [ frozenTime ]
		ifFalse: [ self currentTime ]
]

{ #category : #'api - time' }
BlTime >> nowInUTCMicroseconds [

	^ frozen
		ifTrue: [ frozenTime utcMicroSeconds ]
		ifFalse: [ self currentUTCMicroseconds ]
]

{ #category : #printing }
BlTime >> printOn: aStream [
	self now printOn: aStream
]

{ #category : #'api - time' }
BlTime >> synchronized: aBlock [
	"Make this time instance synchronized among all users.
	During evaluation of aBlock #now will return the same time, independent of
	how much time actually passed between calls"
	
	frozen := true.
	frozenTime := self currentTime.
	aBlock ensure: [
		frozen := false.
		frozenTime := nil ]
]

{ #category : #'api - time' }
BlTime >> wait: aDuration [
	"Advance clock by waiting for a given amount of time"

	self subclassResponsibility
]
