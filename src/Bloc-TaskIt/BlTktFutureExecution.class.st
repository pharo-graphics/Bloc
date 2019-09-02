Class {
	#name : #BlTktFutureExecution,
	#superclass : #TKTFutureExecution,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-TaskIt-TaskIt Tasks'
}

{ #category : #evaluating }
BlTktFutureExecution >> doExecuteTask [

	[ future deploySuccess: task value ]
		on: Error
		do: [ :error | error class = BlTktExplicitlyTerminatedTaskException 
			ifTrue: [ 
				BlTaskItSignal emitValuable: task message: #futureTerminated.
				nil ]
			ifFalse: [ future deployFailure: error freeze ] ].

]
