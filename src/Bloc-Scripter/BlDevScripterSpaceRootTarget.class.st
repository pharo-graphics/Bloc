Class {
	#name : #BlDevScripterSpaceRootTarget,
	#superclass : #BlDevScripterTarget,
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterSpaceRootTarget >> findTargetIn: anElement [
	<return: #BlElement>
	self 
		assert: [ anElement isAttachedToSceneGraph ]
		description: [ 'Element must be in space' ].
	^ anElement space root
]

{ #category : #searching }
BlDevScripterSpaceRootTarget >> findTargetStartingInScripter: aScripter [
	^ aScripter space root
]

{ #category : #accessing }
BlDevScripterSpaceRootTarget >> identifier [
	^ 'space root'
]

{ #category : #printing }
BlDevScripterSpaceRootTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Space Root'.
]

{ #category : #updating }
BlDevScripterSpaceRootTarget >> updateUsing: aScripterEventTarget on: aStep [
	| aNestedTarget |
	aNestedTarget := BlDevScripterNestedChildEventTarget new.
	aNestedTarget targets: { self. aScripterEventTarget }.
	aStep target: aNestedTarget.
]
