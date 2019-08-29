Extension { #name : #TKTWorker }

{ #category : #'*Bloc-TaskIt' }
TKTWorker >> entryIdentifier [ 

	^process entryIdentifier 

]

{ #category : #'*Bloc-TaskIt' }
TKTWorker >> taskName [

	^process
		ifNil: [ '<no task>' ]
		ifNotNil: [ process taskName ]
]
