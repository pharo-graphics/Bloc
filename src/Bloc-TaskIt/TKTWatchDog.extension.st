Extension { #name : #TKTWatchDog }

{ #category : #'*Bloc-TaskIt' }
TKTWatchDog >> hasPoolWorkerNamed: aString [
	^ self pool 
			ifNotNil: [ :aPool | aPool name = aString ]
			ifNil: [ false ]
]

{ #category : #'*Bloc-TaskIt' }
TKTWatchDog >> numberOfFailedTasks [
	^ self pool 
			ifNotNil: [ :aPool | aPool numberOfFailedTasks ]
			ifNil: 0
]

{ #category : #'*Bloc-TaskIt' }
TKTWatchDog >> taskQueueSize [
	^ self pool 
			ifNotNil: [ :aPool | aPool taskQueue size ]
			ifNil: 0
]
