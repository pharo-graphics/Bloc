"
Is sent after a space is attached to the root

"
Class {
	#name : 'BlParallelUniverseSpaceRootAssignedSignal',
	#superclass : 'BlParallelUniverseSpaceSignal',
	#package : 'Bloc',
	#tag : 'Universe - Parallel'
}

{ #category : 'accessing' }
BlParallelUniverseSpaceRootAssignedSignal class >> label [
	^ 'Assign space to root element'
]

{ #category : 'accessing' }
BlParallelUniverseSpaceRootAssignedSignal class >> nextSignals [
	^ { BlParallelUniverseSpaceDispatchAddedToSceneSignal }
]
