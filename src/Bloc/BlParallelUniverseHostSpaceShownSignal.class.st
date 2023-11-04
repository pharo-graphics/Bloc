"
Is sent after a host space is shown

"
Class {
	#name : 'BlParallelUniverseHostSpaceShownSignal',
	#superclass : 'BlParallelUniverseSpaceSignal',
	#category : 'Bloc-Universe - Parallel',
	#package : 'Bloc',
	#tag : 'Universe - Parallel'
}

{ #category : 'accessing' }
BlParallelUniverseHostSpaceShownSignal class >> label [
	^ 'Show space host'
]

{ #category : 'accessing' }
BlParallelUniverseHostSpaceShownSignal class >> nextSignals [
	^ { BlParallelUniverseSpaceRootAssignedSignal }
]
