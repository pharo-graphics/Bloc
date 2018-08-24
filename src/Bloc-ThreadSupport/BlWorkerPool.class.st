Class {
	#name : #BlWorkerPool,
	#superclass : #TKTWorkerPool,
	#category : 'Bloc-ThreadSupport'
}

{ #category : #'as yet unclassified' }
BlWorkerPool >> initialize [
	super initialize.
	self poolMaxSize: 4.
	
]

{ #category : #'as yet unclassified' }
BlWorkerPool >> withBackgroundPriority [
	poolWorker process process priority: Processor userBackgroundPriority
]
