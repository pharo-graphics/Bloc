Extension { #name : #TKTWorkerProcess }

{ #category : #'*Bloc-TaskIt' }
TKTWorkerProcess >> entryIdentifier [ 

	^currentTaskExecution entryIdentifier
]

{ #category : #'*Bloc-TaskIt' }
TKTWorkerProcess >> taskName [

	^currentTaskExecution
		ifNil: [ '<no task>' ]
		ifNotNil: [ currentTaskExecution name ]
]
