"
I am sent when a there was a deferred action added to the universe using ==defer:==
"
Class {
	#name : #BlParallelUniverseDeferredActionAddedSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseDeferredActionAddedSignal class >> isRepeatable [
	^ true
]

{ #category : #accessing }
BlParallelUniverseDeferredActionAddedSignal class >> label [
	^ 'Add deferred action'
]

{ #category : #accessing }
BlParallelUniverseDeferredActionAddedSignal class >> nextSignals [
	^ { BlParallelUniverseHostStartRequestSignal . BlParallelUniverseTryToRunDeferredActionsSignal }
]

{ #category : #accessing }
BlParallelUniverseDeferredActionAddedSignal >> action [
	^ action
]

{ #category : #accessing }
BlParallelUniverseDeferredActionAddedSignal >> action: anObject [
	action := anObject
]
