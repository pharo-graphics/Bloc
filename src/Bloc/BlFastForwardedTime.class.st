"
I am a time with an ability to manipulate its speed, make it run faster or go slower.

```
	| aTime |
	aTime := BlTime fastForwarded.
	aTime speed: 0.5. ""slow down""
	aTime speed: 2. ""speed up""
	aTime now
```

"
Class {
	#name : #BlFastForwardedTime,
	#superclass : #BlTime,
	#instVars : [
		'speed',
		'previousRealTime',
		'previousSpeededUpTime'
	],
	#category : #'Bloc-Universe'
}

{ #category : #'private - time' }
BlFastForwardedTime >> currentTime [
	"Return a 'current' date and time"

	| aSpeededTime aDelta aCurrentRealTime |
	
	aCurrentRealTime := DateAndTime now.
	
	aDelta := aCurrentRealTime - previousRealTime.
	
	aSpeededTime := previousSpeededUpTime + (aDelta * self speed).
	
	previousSpeededUpTime := aSpeededTime.
	previousRealTime := aCurrentRealTime.
	
	^ aSpeededTime
]

{ #category : #'api - enumeration' }
BlFastForwardedTime >> every: aDuration while: aWhileBlock do: aDoBlock [
	"Evaluate a aDoBlock while aWhileBlock evaluates to true waiting a given amount of time between executions.
	The first evaluation of a aDoBlock is instant.
	Note: evaluation is synchronous"
	| aStartTime aCount |

	aStartTime := self now.
	aCount := 0.

	aWhileBlock whileTrue: [
		| anExpectedTime aCurrentTime |
		aDoBlock value.
		
		aCount := aCount + 1.
		
		anExpectedTime := aStartTime + (aDuration * self speed * aCount).
		aCurrentTime := self now.
		(anExpectedTime - aCurrentTime) wait ]
]

{ #category : #initialization }
BlFastForwardedTime >> initialize [
	super initialize.
	
	speed := 1.0.
	previousRealTime := DateAndTime now.
	previousSpeededUpTime := previousRealTime.
]

{ #category : #'api - accessing' }
BlFastForwardedTime >> speed [
	"Return a number representing the speed."

	^ speed
]

{ #category : #'api - accessing' }
BlFastForwardedTime >> speed: aNumber [
	speed := aNumber
]

{ #category : #'api - time' }
BlFastForwardedTime >> wait: aDuration [
	"Advance clock by waiting for a given amount of time"

	(aDuration / self speed) wait
]
