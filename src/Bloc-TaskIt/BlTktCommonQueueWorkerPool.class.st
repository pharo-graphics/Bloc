Class {
	#name : #BlTktCommonQueueWorkerPool,
	#superclass : #TKTCommonQueueWorkerPool,
	#traits : '(TBlDebug + TBlTktCommandTaskScheduler) - {#processProvider}',
	#classTraits : 'TBlDebug classTrait + TBlTktCommandTaskScheduler classTrait',
	#instVars : [
		'processPriority'
	],
	#category : #'Bloc-TaskIt-Workers'
}

{ #category : #initialization }
BlTktCommonQueueWorkerPool >> initialize [
	super initialize.
	processPriority := Processor userSchedulingPriority.
]

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> printOn: aStream [
	name ifNil: [ aStream nextPutAll: 'a '; nextPutAll: self className. ^ self ].
	aStream nextPutAll: name
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processPriority [
	<return: #Integer>
	^ processPriority
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processPriority: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Worker process priority must be a positive integer' ].
	processPriority := anInteger
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ BlTktProcessProvider new processPriority: self processPriority
]
