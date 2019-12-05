Class {
	#name : #BlTktCommandTaskExecution,
	#superclass : #TKTTaskExecution,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-TaskIt-TaskIt Tasks'
}

{ #category : #evaluating }
BlTktCommandTaskExecution >> doExecuteTask [
	^ [ super doExecuteTask ] 
		on: BlTktExplicitlyTerminatedTaskException
		do: [ :anException | 
			BlTaskItExplicitlyTerminatedCommandSignal emitValuable: task message: #commandTerminated.
			nil ]
]
