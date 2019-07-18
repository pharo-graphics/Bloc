Class {
	#name : #BlTktCommandTaskExecution,
	#superclass : #TKTTaskExecution,
	#traits : 'TBlDebug + TBlTktRequests',
	#classTraits : 'TBlDebug classTrait + TBlTktRequests classTrait',
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #evaluating }
BlTktCommandTaskExecution >> doExecuteTask [
	'doExecuteTask' traceCr.
	TKTConfiguration runner scheduleCommandTaskCheckEvery: self timeout on: self.
	^ super doExecuteTask
]

{ #category : #accessing }
BlTktCommandTaskExecution >> name [
	<return: #String>
	^ task name
]

{ #category : #accessing }
BlTktCommandTaskExecution >> requestContext [
	<return: #TBlTktRequests>
	^ task requestContext
]

{ #category : #initialization }
BlTktCommandTaskExecution >> setExplicitlyTerminatedStateWithReason: aReason [
	state := BlTktExplicitlyTerminatedTaskState new reason: aReason
]

{ #category : #evaluating }
BlTktCommandTaskExecution >> terminateWithReason: aReason [
	state terminateTaskExecution: self reason: aReason
]

{ #category : #accessing }
BlTktCommandTaskExecution >> timeout [
	^ 200 milliSeconds
]
