Class {
	#name : #BlParallelUniverseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'universe',
		'universeID'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #testing }
BlParallelUniverseSignal class >> isAbstract [
	^ self = BlParallelUniverseSignal
]

{ #category : #accessing }
BlParallelUniverseSignal class >> isRepeatable [
	"Return true if this signal is expected to be emitted regularly"
	<return: #Boolean>

	^ false
]

{ #category : #accessing }
BlParallelUniverseSignal class >> label [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlParallelUniverseSignal class >> nextSignals [
	"Return a collection of possible signals after this one"
	^ #()
]

{ #category : #accessing }
BlParallelUniverseSignal >> universe [
	^ universe
]

{ #category : #accessing }
BlParallelUniverseSignal >> universe: aParallelUniverse [
	universe := aParallelUniverse.
	universeID := aParallelUniverse identityHash
]
