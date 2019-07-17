Class {
	#name : #BlTktCommand,
	#superclass : #Object,
	#traits : 'TBlTktRequests + TBlDebug',
	#classTraits : 'TBlTktRequests classTrait + TBlDebug classTrait',
	#instVars : [
		'requests'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #evaluating }
BlTktCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self subclassResponsibility
]

{ #category : #initialization }
BlTktCommand >> initialize [
	super initialize.
	requests := BlTktCommandRequests new.
]

{ #category : #accessing }
BlTktCommand >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTktCommand >> requestContext [
	<return: #TBlTktRequests>
	^ requests
]

{ #category : #evaluating }
BlTktCommand >> value [
	"execute command and return a result"
	<return: #Object>
	^ self ifExecutionExpectedDo: [ self execute ]
]
