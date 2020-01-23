Class {
	#name : #BlUpdateWhenVisibleStrategy,
	#superclass : #BlAsyncElementUpdateStrategy,
	#category : #'Bloc-Async'
}

{ #category : #testing }
BlUpdateWhenVisibleStrategy >> needsUpdate: anAsyncElement [
	<return: #Boolean>
	^ anAsyncElement isAlreadyUpdated not and: [ anAsyncElement isVisibleInSpace ]
]
