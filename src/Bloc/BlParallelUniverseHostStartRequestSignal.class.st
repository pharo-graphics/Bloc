Class {
	#name : #BlParallelUniverseHostStartRequestSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'host'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostStartRequestSignal >> host [
	^ host
]

{ #category : #accessing }
BlParallelUniverseHostStartRequestSignal >> host: anObject [
	host := anObject
]
