Class {
	#name : #BlTktUIWorkerPool,
	#superclass : #BlTktCommandTaskWorkerPool,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #accessing }
BlTktUIWorkerPool class >> defaultName [
	<return: #BlTktCommandTaskWorkerPool>
	^ 'Bloc UI Worker'
]

{ #category : #accessing }
BlTktUIWorkerPool class >> defaultPoolSize [
	<return: #Integer>
	^ 4
]

{ #category : #accessing }
BlTktUIWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ BlTKTBackgroundProcessProvider new
]
