"
Is sent after a host space was created and assigned to the space

"
Class {
	#name : #BlParallelUniverseHostSpaceCreatedSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal class >> label [
	^ 'Create space host'
]

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal class >> nextSignals [
	^ { BlParallelUniverseHostSpaceShownSignal }
]
