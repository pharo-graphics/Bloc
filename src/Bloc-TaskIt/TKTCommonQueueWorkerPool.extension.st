Extension { #name : #TKTCommonQueueWorkerPool }

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> gtWorkersFor: aView [
	<gtView>
	self workers ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Workers';
		items: [ self workers asOrderedCollection ];
		column: 'Name' item: [ :aWorker | aWorker name ];
		column: 'Has Task' item: [ :aWorker | aWorker isFree not ] width: 80;
		column: 'Is Running' item: [ :aWorker | aWorker isRunning ] width: 80
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> poolMaxSize [

	^poolMaxSize
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> privateCheckNotifycationEvery: aTimeout on: aTaskExecution [
	aTimeout wait.
	aTaskExecution isSuspendRequested ifTrue: [
		aTaskExecution suspendWithReason: 'User request at ', DateAndTime now asString ].
	aTaskExecution isFinished ifFalse: [ 
		self scheduleNotifycationEvery: aTimeout on: aTaskExecution ]
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> scheduleNotifycationEvery: aTimeout on: aTaskExecution [
	TKTConfiguration processProvider
		createProcessDoing:
			(MessageSend
				receiver: self
				selector: #privateCheckNotifycationEvery:on:
				arguments:
					{aTimeout.
					aTaskExecution})
		named: 'Notifycation handler on ', aTaskExecution name asString
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> taskQueue [ 

	^taskQueue
]
