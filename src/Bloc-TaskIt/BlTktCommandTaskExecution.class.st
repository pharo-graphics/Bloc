Class {
	#name : #BlTktCommandTaskExecution,
	#superclass : #TKTTaskExecution,
	#traits : 'TBlDebug + TBlTktRequests',
	#classTraits : 'TBlDebug classTrait + TBlTktRequests classTrait',
	#category : #'Bloc-TaskIt-TaskIt Tasks'
}

{ #category : #evaluating }
BlTktCommandTaskExecution >> doExecuteTask [
	TKTConfiguration runner scheduleCommandTaskCheckEvery: self timeout on: self.
	^ [ super doExecuteTask ] 
		on: BlTktExplicitlyTerminatedTaskException
		do: [ :anException | nil ]
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

{ #category : #accessing }
BlTktCommandTaskExecution >> timeout [
	^ 200 milliSeconds
]
