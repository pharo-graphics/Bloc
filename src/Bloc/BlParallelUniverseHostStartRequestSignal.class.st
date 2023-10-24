"
I am sent when a universe requests a host to start

"
Class {
	#name : #BlParallelUniverseHostStartRequestSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#instVars : [
		'host'
	],
	#category : 'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostStartRequestSignal class >> label [
	^ 'Request host start'
]

{ #category : #accessing }
BlParallelUniverseHostStartRequestSignal class >> nextSignals [
	^ { BlParallelUniverseHostStartedSignal }
]

{ #category : #accessing }
BlParallelUniverseHostStartRequestSignal >> host [
	<return: #'BlHost class'>
	
	^ host
]

{ #category : #accessing }
BlParallelUniverseHostStartRequestSignal >> host: aBlHostClass [
	host := aBlHostClass
]
