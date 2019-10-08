Class {
	#name : #BlParallelUniverseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'universe',
		'universeID'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseSignal >> universe [
	^ universe
]

{ #category : #accessing }
BlParallelUniverseSignal >> universe: aParallelUniverse [
	universe := aParallelUniverse.
	universeID := aParallelUniverse identityHash
]
