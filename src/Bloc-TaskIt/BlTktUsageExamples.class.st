Class {
	#name : #BlTktUsageExamples,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Workers'
}

{ #category : #'as yet unclassified' }
BlTktUsageExamples >> uiWorkerPool [
	<gtExample>
	| aPool |
	aPool := self workerProvider ui; pool.
	self assert: aPool name isString.
	self assert: aPool name isNotEmpty.
	self assert: aPool poolMaxSize isNumber.
	self assert: aPool processPriority isNumber.
	^ aPool
]

{ #category : #'as yet unclassified' }
BlTktUsageExamples >> workerProvider [
	<gtExample>
	| aProvider |
	aProvider := BlTktWorkerProvider new.
	self assert: aProvider name isString.
	self assert: aProvider name isNotEmpty.
	self assert: aProvider maxPoolSize isNumber.
	self assert: aProvider processPriority isNumber.
	^ aProvider
]
