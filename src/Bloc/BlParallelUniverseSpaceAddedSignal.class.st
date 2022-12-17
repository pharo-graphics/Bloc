"
Is sent when a space was added to the space manager in a universe

"
Class {
	#name : #BlParallelUniverseSpaceAddedSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseSpaceAddedSignal class >> label [
	^ 'Add space'
]

{ #category : #accessing }
BlParallelUniverseSpaceAddedSignal class >> nextSignals [
	^ { BlParallelUniverseHostSpaceCreatedSignal }
]
