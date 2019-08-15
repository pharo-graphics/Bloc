Class {
	#name : #BlTktCommonPriorityQueueWorkerPool,
	#superclass : #BlTktCommonQueueWorkerPool,
	#category : #'Bloc-TaskIt-Workers'
}

{ #category : #initialization }
BlTktCommonPriorityQueueWorkerPool >> initialize [ 
	super initialize.
	taskQueue := SharedPriorityUniqueQueue new.
]
