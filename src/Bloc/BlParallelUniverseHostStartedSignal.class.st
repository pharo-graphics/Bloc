"
I am sent when a universe started a host

"
Class {
	#name : #BlParallelUniverseHostStartedSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#instVars : [
		'host',
		'isRunning'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostStartedSignal class >> label [
	^ 'Start host'
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal class >> nextSignals [
	^ { BlParallelUniverseTryToRunDeferredActionsSignal }
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> host [
	<return: #'BlHost class'>

	^ host
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> host: aBlHostClass [
	host := aBlHostClass
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> isRunning [
	^ isRunning
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> isRunning: anObject [
	isRunning := anObject
]
