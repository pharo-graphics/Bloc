"
Is sent after a host space is shown
"
Class {
	#name : #BlParallelUniverseHostSpaceShownSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#instVars : [
		'hostSpace'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostSpaceShownSignal class >> label [
	^ 'Show space host'
]

{ #category : #accessing }
BlParallelUniverseHostSpaceShownSignal class >> nextSignals [
	^ { BlParallelUniverseSpaceRootAssignedSignal }
]

{ #category : #accessing }
BlParallelUniverseHostSpaceShownSignal >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlParallelUniverseHostSpaceShownSignal >> hostSpace: anObject [
	hostSpace := anObject
]
