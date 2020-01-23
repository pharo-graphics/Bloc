Class {
	#name : #BlUpdateWhenInSceneStrategy,
	#superclass : #BlAsyncElementUpdateStrategy,
	#category : #'Bloc-Async'
}

{ #category : #testing }
BlUpdateWhenInSceneStrategy >> needsUpdate: anAsyncElement [
	<return: #Boolean>
	^ anAsyncElement isAlreadyUpdated not and: [ anAsyncElement isAttachedToSceneGraph ]
]
