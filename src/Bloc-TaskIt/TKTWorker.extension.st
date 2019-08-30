Extension { #name : #TKTWorker }

{ #category : #'*Bloc-TaskIt' }
TKTWorker >> entryIdentifier [ 

	^process entryIdentifier 

]

{ #category : #'*Bloc-TaskIt' }
TKTWorker >> isSuspended [

	^process isSuspended
]

{ #category : #'*Bloc-TaskIt' }
TKTWorker >> stopAfterTaskCompleted [
	"Stop after the current task has been completed"

	^process stopAfterTaskCompleted

]

{ #category : #'*Bloc-TaskIt' }
TKTWorker >> taskName [

	^process
		ifNil: [ '<no task>' ]
		ifNotNil: [ process taskName ]
]
