Class {
	#name : #BlParallelUniverseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'universe',
		'space'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseSignal >> space [
	^ space
]

{ #category : #accessing }
BlParallelUniverseSignal >> space: anObject [
	space := anObject
]

{ #category : #accessing }
BlParallelUniverseSignal >> universe [
	^ universe
]

{ #category : #accessing }
BlParallelUniverseSignal >> universe: anObject [
	universe := anObject
]
