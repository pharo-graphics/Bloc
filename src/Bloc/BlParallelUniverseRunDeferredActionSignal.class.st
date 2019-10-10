"
Is sent when a universe performed a deferred action
"
Class {
	#name : #BlParallelUniverseRunDeferredActionSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseRunDeferredActionSignal class >> isRepeatable [
	^ true
]

{ #category : #accessing }
BlParallelUniverseRunDeferredActionSignal class >> label [
	^ 'Run deferred action'
]

{ #category : #accessing }
BlParallelUniverseRunDeferredActionSignal class >> nextSignals [
	^ { BlParallelUniverseRunDeferredActionSignal . BlParallelUniverseSpaceAddedSignal }
]

{ #category : #accessing }
BlParallelUniverseRunDeferredActionSignal >> action [
	^ action
]

{ #category : #accessing }
BlParallelUniverseRunDeferredActionSignal >> action: anObject [
	action := anObject
]
