"
I am a just a traditional real time.

```
	| aTime |
	aTime := BlTime real.
	aTime now
```

"
Class {
	#name : #BlRealTime,
	#superclass : #BlTime,
	#category : #'Bloc-Universe'
}

{ #category : #'private - time' }
BlRealTime >> currentTime [
	"Return a 'current' date and time"
	<return: #DateAndTime>

	^ DateAndTime now
]

{ #category : #'private - time' }
BlRealTime >> currentUTCMicroseconds [

	^ Time microsecondClockValue 
]

{ #category : #'api - enumeration' }
BlRealTime >> every: aDuration while: aWhileBlock do: aDoBlock [
	"Evaluate a aDoBlock while aWhileBlock evaluates to true waiting a given amount of time between executions.
	The first evaluation of a aDoBlock is instant.
	Note: evaluation is synchronous"
	| aStartTime aCount |

	aStartTime := self now.
	aCount := 0.

	[aWhileBlock value] whileTrue: [
		| anExpectedTime aCurrentTime aWaitingTime |
		aDoBlock value.
		
		aCount := aCount + 1.
		
		anExpectedTime := aStartTime + (aDuration * aCount).
		aCurrentTime := self now.
		aWaitingTime := anExpectedTime - aCurrentTime.
		0 seconds < aWaitingTime ifTrue: [ aWaitingTime wait ] ]
]

{ #category : #'api - time' }
BlRealTime >> wait: aDuration [
	"Advance clock by waiting for a given amount of time"

	aDuration wait
]
