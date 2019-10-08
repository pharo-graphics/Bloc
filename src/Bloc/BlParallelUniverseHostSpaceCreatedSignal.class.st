"
Is sent after a host space was created and assigned to the space
"
Class {
	#name : #BlParallelUniverseHostSpaceCreatedSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'hostSpace'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal >> hostSpace: anObject [
	hostSpace := anObject
]
