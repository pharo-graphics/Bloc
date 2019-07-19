Trait {
	#name : #TBlTktCommandTaskScheduler,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #private }
TBlTktCommandTaskScheduler >> privateCheckCommandTaskEvery: aTimeout on: aTaskExecution [
	"At this moment we support only cancel request. 
	We cannot suspend and resume a process."
	| shouldFinish |
	self traceCr: 'privateCheckCommandTaskEvery:on:'.
	shouldFinish := false.
	[ shouldFinish or: [ aTaskExecution isFinished ] ] whileFalse: [
		aTimeout wait.
		self traceCr: 'privateCheckCommandTaskEvery:on: iteration'.
		aTaskExecution isFinished ifFalse: [  
			aTaskExecution aboutToCheckCallback value.
			aTaskExecution isTerminationRequested ifTrue: [ 
				aTaskExecution cancelWithReason: 'User termination request at', DateAndTime now asString.
				shouldFinish := true.
				"aTaskExecution terminateWithReason: 'User request at', DateAndTime now asString" ].
			aTaskExecution isSuspendRequested ifTrue: [
				aTaskExecution cancelWithReason: 'User suspend request at', DateAndTime now asString.
				shouldFinish := true.
				"aTaskExecution suspendWithReason: 'User request at ', DateAndTime now asString" ].
			aTaskExecution isResumeRequested ifTrue: [
				aTaskExecution resume ].
			aTaskExecution checkFinishedCallback value ] ].
]

{ #category : #scheduling }
TBlTktCommandTaskScheduler >> scheduleCommandTaskCheckEvery: aTimeout on: aTaskExecution [
	self logCr: #scheduleCommandTaskCheckEvery:on:.
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
