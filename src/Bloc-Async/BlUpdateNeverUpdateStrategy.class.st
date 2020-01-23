Class {
	#name : #BlUpdateNeverUpdateStrategy,
	#superclass : #BlAsyncElementUpdateStrategy,
	#category : #'Bloc-Async'
}

{ #category : #testing }
BlUpdateNeverUpdateStrategy >> needsUpdate: anAsyncElement [
	<return: #Boolean>
	^ false
]
