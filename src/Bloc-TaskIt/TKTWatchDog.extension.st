Extension { #name : #TKTWatchDog }

{ #category : #'*Bloc-TaskIt' }
TKTWatchDog >> hasPoolWorkerNamed: aString [
	^ self pool 
			ifNotNil: [ :aPool | aPool name = aString ]
			ifNil: [ false ]
]
