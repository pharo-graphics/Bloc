Trait {
	#name : #TBlTktCommandTaskScheduler,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #private }
TBlTktCommandTaskScheduler >> privateCheckCommandTaskEvery: aTimeout on: aTaskExecution [
	"At this moment we support only cancel request. 
	We cannot suspend and resume a process.
	TODO: we should rather schedule again aTaskExecution to ensure that other checks get time to check"
	| shouldFinish |
	shouldFinish := false.
	[ shouldFinish or: [ aTaskExecution isFinished ] ] whileFalse: [
		aTimeout wait.
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

{ #category : #accessing }
TBlTktCommandTaskScheduler >> processProvider [
	^ TKTConfiguration processProvider
]

{ #category : #scheduling }
TBlTktCommandTaskScheduler >> scheduleCommandTaskCheckEvery: aTimeout on: aTaskExecution [
	self processProvider
		createProcessDoing:
			(MessageSend
				receiver: self
				selector: #privateCheckCommandTaskEvery:on:
				arguments:
					{aTimeout.
					aTaskExecution})
		named: 'Task Checker for ', aTaskExecution name asString
]
