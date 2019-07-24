Trait {
	#name : #TBlTktRequests,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-TaskIt-Command Context'
}

{ #category : #callbacks }
TBlTktRequests >> aboutToCheckCallback [
	"Return an object that understands the #value message"
	<return: #BlockClosure>
	^ self requestContext aboutToCheckCallback
]

{ #category : #callbacks }
TBlTktRequests >> aboutToCheckCallback: aValuable [
	"aValuable callback is an object that understands the #value message"
	^ self requestContext aboutToCheckCallback: aValuable
]

{ #category : #callbacks }
TBlTktRequests >> checkFinishedCallback [
	"Return an object that understands the #value message"
	<return: #BlockClosure>
	^ self requestContext checkFinishedCallback
]

{ #category : #callbacks }
TBlTktRequests >> checkFinishedCallback: aValuable [
	"aValuable callback is an object that understands the #value message"
	^ self requestContext checkFinishedCallback: aValuable
]

{ #category : #enumerating }
TBlTktRequests >> ifExecutionExpectedDo: aBlock [
	<return: #Object>
	^ self isExecutionExpected ifTrue: aBlock
]

{ #category : #accessing }
TBlTktRequests >> invocatedByElement [
	<return: #BlElement>
	^ self userData at: #element ifAbsent: [ nil ]
]

{ #category : #accessing }
TBlTktRequests >> invocatedByElement: anElement [
	self 
		assert: [ anElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	self userData at: #element put: anElement
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

{ #category : #accessing }
TBlTktRequests >> userData [
	^ self requestContext userData
]
