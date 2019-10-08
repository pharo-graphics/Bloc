"
Is signalled when someone requests a universe to open a space.
"
Class {
	#name : #BlParallelUniverseOpenSpaceRequestSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'isRunning'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseOpenSpaceRequestSignal >> isRunning [
	^ isRunning
]

{ #category : #accessing }
BlParallelUniverseOpenSpaceRequestSignal >> isRunning: anObject [
	isRunning := anObject
]
