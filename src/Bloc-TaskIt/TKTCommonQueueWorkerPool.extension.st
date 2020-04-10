Extension { #name : #TKTCommonQueueWorkerPool }

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> finalize [ 

	self stop.
	super finalize.

]

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
TKTCommonQueueWorkerPool >> isFree [
	<return: #Boolean>
	^ taskQueue isEmpty and: [ workers allSatisfy: [ :each | each isFree ] ]
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> killWatchDog [
	dog ifNotNil: [ :aWatchDog | aWatchDog kill ]
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> numberOfFailedTasks [
	<return: #Integer>
	^ failedTasks ifNotNil: #size ifNil: 0
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> poolMaxSize [

	^poolMaxSize
]

{ #category : #'*Bloc-TaskIt' }
TKTCommonQueueWorkerPool >> taskQueue [ 

	^taskQueue
]
