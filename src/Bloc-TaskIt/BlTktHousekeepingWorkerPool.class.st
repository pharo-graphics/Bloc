Class {
	#name : #BlTktHousekeepingWorkerPool,
	#superclass : #BlTktCommandTaskWorkerPool,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #accessing }
BlTktHousekeepingWorkerPool class >> defaultName [
	<return: #BlTktCommandTaskWorkerPool>
	^ 'Bloc Housekeeping'
]

{ #category : #accessing }
BlTktHousekeepingWorkerPool class >> defaultPoolSize [
	<return: #Integer>
	^ 1
]
