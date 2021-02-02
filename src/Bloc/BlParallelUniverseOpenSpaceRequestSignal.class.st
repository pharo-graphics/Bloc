"
Is signalled when someone requests a universe to open a space.
"
Class {
	#name : #BlParallelUniverseOpenSpaceRequestSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#instVars : [
		'isRunning'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseOpenSpaceRequestSignal class >> label [
	^ 'Request open space'
]

{ #category : #accessing }
BlParallelUniverseOpenSpaceRequestSignal class >> nextSignals [
	^ { BlParallelUniverseDeferredActionAddedSignal }
]

{ #category : #accessing }
BlParallelUniverseOpenSpaceRequestSignal >> isRunning [
	^ isRunning
]

{ #category : #accessing }
BlParallelUniverseOpenSpaceRequestSignal >> isRunning: anObject [
	isRunning := anObject
]
