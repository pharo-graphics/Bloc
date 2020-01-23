"
If I am used, a ${class:BlAsyncElement}$ instance is never updated.
To use me, call ${method:BlAsyncElement>>#neverUpdate}$.
This is a special case, when an instance is updated differently.

"
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
