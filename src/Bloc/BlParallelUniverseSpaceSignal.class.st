Class {
	#name : #BlParallelUniverseSpaceSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'spaceId'
	],
	#category : 'Bloc-Universe - Parallel'
}

{ #category : 'testing' }
BlParallelUniverseSpaceSignal class >> isAbstract [
	^ self = BlParallelUniverseSpaceSignal
]

{ #category : 'accessing' }
BlParallelUniverseSpaceSignal >> spaceId [
	<return: #Number>

	^ spaceId
]

{ #category : 'accessing' }
BlParallelUniverseSpaceSignal >> spaceId: aNumber [
	spaceId := aNumber
]
