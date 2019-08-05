Extension { #name : #TKTWorker }

{ #category : #'*Bloc-TaskIt' }
TKTWorker >> taskName [

	^process
		ifNil: [ '<no task>' ]
		ifNotNil: [ process taskName ]
]
