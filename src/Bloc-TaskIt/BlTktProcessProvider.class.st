Class {
	#name : #BlTktProcessProvider,
	#superclass : #TKTTaskItProcessProvider,
	#instVars : [
		'processPriority',
		'processClass'
	],
	#category : #'Bloc-TaskIt-Processes'
}

{ #category : #'instance-creation' }
BlTktProcessProvider >> createProcessDoing: aValuable named: aName [
	^ (self processClass send: #value to: aValuable)
		annotate: #task with: aValuable;
		name: aName;
		priority: self processPriority;
		run
]

{ #category : #defaults }
BlTktProcessProvider >> defaultProcessClass [
	^ BlTktProcess
]

{ #category : #defaults }
BlTktProcessProvider >> defaultProcessPriority [
	^ Processor userSchedulingPriority
]

{ #category : #initialization }
BlTktProcessProvider >> initialize [
	super initialize.
	self processClass: self defaultProcessClass.
	self processPriority: self defaultProcessPriority.
]

{ #category : #accessing }
BlTktProcessProvider >> processClass [
	<return: #Process>
	^ processClass
]

{ #category : #accessing }
BlTktProcessProvider >> processClass: aClass [
	self 
		assert: [ aClass isNotNil ]
		description: [ 'Process class must be non-nil' ].
	processClass := aClass
]

{ #category : #accessing }
BlTktProcessProvider >> processPriority [
	<return: #Integer>
	^ processPriority
]

{ #category : #accessing }
BlTktProcessProvider >> processPriority: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Worker process priority must be a positive integer' ].
	processPriority := anInteger
]
