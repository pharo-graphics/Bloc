Class {
	#name : #BlParallelUniverseSpaceSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #testing }
BlParallelUniverseSpaceSignal class >> isAbstract [
	^ self = BlParallelUniverseSpaceSignal
]

{ #category : #accessing }
BlParallelUniverseSpaceSignal >> space [
	^ space
]

{ #category : #accessing }
BlParallelUniverseSpaceSignal >> space: anObject [
	space := anObject
]
