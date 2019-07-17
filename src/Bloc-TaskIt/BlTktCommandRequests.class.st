Class {
	#name : #BlTktCommandRequests,
	#superclass : #Object,
	#traits : 'TBlTktRequests',
	#classTraits : 'TBlTktRequests classTrait',
	#instVars : [
		'isSuspendRequested',
		'isResumeRequested',
		'isTerminationRequested'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #initialization }
BlTktCommandRequests >> initialize [
	super initialize.
	isResumeRequested := false.
	isSuspendRequested := false.
	isTerminationRequested := false.
]

{ #category : #testing }
BlTktCommandRequests >> isResumeRequested [
	^ isResumeRequested
]

{ #category : #testing }
BlTktCommandRequests >> isSuspendRequested [
	^ isSuspendRequested
]

{ #category : #testing }
BlTktCommandRequests >> isTerminationRequested [
	^ isTerminationRequested
]

{ #category : #accessing }
BlTktCommandRequests >> requestContext [
	<return: #TBlTktRequests>
	^ self
]

{ #category : #requests }
BlTktCommandRequests >> resumeRequested [
	isResumeRequested := true.
	isSuspendRequested := false.
	isTerminationRequested := false.
]

{ #category : #requests }
BlTktCommandRequests >> suspendRequested [
	isResumeRequested := false.
	isSuspendRequested := true.
	isTerminationRequested := false.
]

{ #category : #requests }
BlTktCommandRequests >> terminationRequested [
	isResumeRequested := false.
	isSuspendRequested := false.
	isTerminationRequested := true.
]
