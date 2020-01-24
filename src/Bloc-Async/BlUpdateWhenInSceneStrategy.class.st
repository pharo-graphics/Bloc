"
If I am used, a ${class:BlAsyncElement}$ instance is updated when attached to a scene (it can still be invisible to a user).
To use me, call ${method:BlAsyncElement>>#updateWhenInScene}$.
"
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
