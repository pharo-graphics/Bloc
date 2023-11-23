"
Is sent when a universe tries to run deferred actions

"
Class {
	#name : #BlParallelUniverseTryToRunDeferredActionsSignal,
	#superclass : #BlParallelUniverseSignal,
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseTryToRunDeferredActionsSignal class >> isRepeatable [
	^ true
]

{ #category : #accessing }
BlParallelUniverseTryToRunDeferredActionsSignal class >> label [
	^ 'Try to run deferred actions'
]

{ #category : #accessing }
BlParallelUniverseTryToRunDeferredActionsSignal class >> nextSignals [
	^ { BlParallelUniverseRunDeferredActionSignal }
]
