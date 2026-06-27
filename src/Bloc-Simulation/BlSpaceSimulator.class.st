Class {
	#name : #BlSpaceSimulator,
	#superclass : #Object,
	#instVars : [
		'space',
		'timeout'
	],
	#category : #'Bloc-Simulation'
}

{ #category : #'instance creation' }
BlSpaceSimulator class >> forSpace: aSpace [
	^ self new
		space: aSpace;
		yourself
]

{ #category : #initialization }
BlSpaceSimulator >> initialize [
	super initialize.
	timeout := 500 milliSeconds
]

{ #category : #testing }
BlSpaceSimulator >> isShown [
	^ space isShown
]

{ #category : #stepping }
BlSpaceSimulator >> pulseUntilEmptyTaskQueue [
	"Wait until the space doesn't have available tasks to execute."

	^ space host waitEmptyTaskQueueFor: space timeout: timeout
]

{ #category : #stepping }
BlSpaceSimulator >> pulseUntilSpaceShownAndEmptyTaskQueue [
	"Wait until the space is shown and doesn't have available tasks to execute."

	^ space host waitShownAndEmptyTaskQueueFor: space timeout: timeout
]

{ #category : #accessing }
BlSpaceSimulator >> space: aSpace [
	space := aSpace
]

{ #category : #accessing }
BlSpaceSimulator >> timeout [
	^ timeout
]

{ #category : #accessing }
BlSpaceSimulator >> timeout: aDuration [
	timeout := aDuration
]
