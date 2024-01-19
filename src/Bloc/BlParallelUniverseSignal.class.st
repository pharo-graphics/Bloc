Class {
	#name : 'BlParallelUniverseSignal',
	#superclass : 'BeaconSignal',
	#instVars : [
		'universeId'
	],
	#category : 'Bloc-Universe - Parallel',
	#package : 'Bloc',
	#tag : 'Universe - Parallel'
}

{ #category : 'testing' }
BlParallelUniverseSignal class >> isAbstract [
	^ self = BlParallelUniverseSignal
]

{ #category : 'accessing' }
BlParallelUniverseSignal class >> isRepeatable [
	"Return true if this signal is expected to be emitted regularly"

	^ false
]

{ #category : 'accessing' }
BlParallelUniverseSignal class >> label [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlParallelUniverseSignal class >> nextSignals [
	"Return a collection of possible signals after this one"
	^ #()
]

{ #category : 'accessing' }
BlParallelUniverseSignal >> universeId [
	^ universeId
]

{ #category : 'accessing' }
BlParallelUniverseSignal >> universeId: aNumber [
	universeId := aNumber
]
