Class {
	#name : #BlTktUIWorkerPool,
	#superclass : #BlTktCommandTaskWorkerPool,
	#category : #'Bloc-TaskIt-Workers'
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

{ #category : #initialization }
BlTktUIWorkerPool >> initialize [ 

	super initialize.
	taskQueue := AtomicSharedPriorityQueue new.
]

{ #category : #accessing }
BlTktUIWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ BlTKTBackgroundProcessProvider new
]
