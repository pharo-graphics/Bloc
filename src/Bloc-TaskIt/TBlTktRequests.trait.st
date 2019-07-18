Trait {
	#name : #TBlTktRequests,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #enumerating }
TBlTktRequests >> ifExecutionExpectedDo: aBlock [
	<return: #Object>
	^ self isExecutionExpected ifTrue: aBlock
]

{ #category : #testing }
TBlTktRequests >> isExecutionExpected [
	<return: #Boolean>
	^ self isSuspendRequested not and: [ self isTerminationRequested not ]
]

{ #category : #testing }
TBlTktRequests >> isResumeRequested [
	<return: #Boolean>
	^ self requestContext isResumeRequested
]

{ #category : #testing }
TBlTktRequests >> isSuspendRequested [
	<return: #Boolean>
	^ self requestContext isSuspendRequested
]

{ #category : #testing }
TBlTktRequests >> isTerminationRequested [
	<return: #Boolean>
	^ self requestContext isTerminationRequested
]

{ #category : #accessing }
TBlTktRequests >> requestContext [
	<return: #TBlTktRequests>
	^ self explicitRequirement
]

{ #category : #testing }
TBlTktRequests >> resumeRequested [  
	self requestContext resumeRequested
]

{ #category : #testing }
TBlTktRequests >> suspendRequested [ 
	self requestContext suspendRequested
]

{ #category : #testing }
TBlTktRequests >> terminationRequested [
	self requestContext terminationRequested
]
