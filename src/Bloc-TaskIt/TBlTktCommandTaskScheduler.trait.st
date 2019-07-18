Trait {
	#name : #TBlTktCommandTaskScheduler,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #private }
TBlTktCommandTaskScheduler >> privateCheckCommandTaskEvery: aTimeout on: aTaskExecution [
	[ aTaskExecution isFinished ] whileFalse: [
		aTimeout wait.
		aTaskExecution isFinished ifFalse: [  
			aTaskExecution isTerminationRequested ifTrue: [ 
				aTaskExecution terminateWithReason: 'User request at', DateAndTime now asString ].
			aTaskExecution isSuspendRequested ifTrue: [
				aTaskExecution suspendWithReason: 'User request at ', DateAndTime now asString ].
			aTaskExecution isResumeRequested ifTrue: [
				aTaskExecution resume ] ] ].
]

{ #category : #scheduling }
TBlTktCommandTaskScheduler >> scheduleCommandTaskCheckEvery: aTimeout on: aTaskExecution [
	TKTConfiguration processProvider
		createProcessDoing:
			(MessageSend
				receiver: self
				selector: #privateCheckCommandTaskEvery:on:
				arguments:
					{aTimeout.
					aTaskExecution})
		named: 'Command Task Checker for ', aTaskExecution name asString
]
