Class {
	#name : #BlTktCommandTaskFutureExecution,
	#superclass : #TKTFutureExecution,
	#traits : 'TBlDebug + TBlTktRequests',
	#classTraits : 'TBlDebug classTrait + TBlTktRequests classTrait',
	#category : #'Bloc-TaskIt-TaskIt Tasks'
}

{ #category : #evaluating }
BlTktCommandTaskFutureExecution >> doExecuteTask [
	TKTConfiguration runner scheduleCommandTaskCheckEvery: self timeout on: self.
	^ super doExecuteTask
]

{ #category : #accessing }
BlTktCommandTaskFutureExecution >> name [
	<return: #String>
	^ task name
]

{ #category : #accessing }
BlTktCommandTaskFutureExecution >> requestContext [
	<return: #TBlTktRequests>
	^ task
]

{ #category : #accessing }
BlTktCommandTaskFutureExecution >> timeout [
	^ 200 milliSeconds
]
