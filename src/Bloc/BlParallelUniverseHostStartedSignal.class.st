Class {
	#name : #BlParallelUniverseHostStartedSignal,
	#superclass : #BlParallelUniverseSignal,
	#instVars : [
		'host',
		'isRunning'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> host [
	^ host
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> host: anObject [
	host := anObject
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> isRunning [
	^ isRunning
]

{ #category : #accessing }
BlParallelUniverseHostStartedSignal >> isRunning: anObject [
	isRunning := anObject
]
