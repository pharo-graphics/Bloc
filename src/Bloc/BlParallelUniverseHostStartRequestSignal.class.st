"
I am sent when a universe requests a host to start
"
Class {
	#name : #BlParallelUniverseHostStartRequestSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
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
