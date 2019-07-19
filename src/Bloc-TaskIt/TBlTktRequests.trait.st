Trait {
	#name : #TBlTktRequests,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #callbacks }
TBlTktRequests >> aboutToCheckCallback [
	"Return an object that understands the #value message"
	<return: #BlockClosure>
	^ self requestContext aboutToCheckCallback
]

{ #category : #callbacks }
TBlTktRequests >> checkFinishedCallback [
	"Return an object that understands the #value message"
	<return: #BlockClosure>
	^ self requestContext checkFinishedCallback
]

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

{ #category : #requests }
TBlTktRequests >> resumeRequested [  
	self requestContext resumeRequested
]

{ #category : #requests }
TBlTktRequests >> suspendRequested [ 
	self requestContext suspendRequested
]

{ #category : #requests }
TBlTktRequests >> terminationRequested [
	self requestContext terminationRequested
]
