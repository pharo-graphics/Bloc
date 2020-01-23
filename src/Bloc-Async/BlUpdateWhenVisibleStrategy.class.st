"
If I am used, a ${class:BlAsyncElement}$ instance is updated when visible on the screen.
To use me, call ${method:BlAsyncElement>>#updateWhenVisible}$.
"
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
