Extension { #name : #TKTServiceManager }

{ #category : #'*Bloc-TaskIt' }
TKTServiceManager >> poolWorkerNamed: aString [
	<return: #TKTCommonQueueWorkerPool or: nil>
	^ self services 
		detect: [ :any | any hasPoolWorkerNamed: aString ]
		ifFound: [ :aService | aService pool ]
		ifNone: [ nil ]
]
