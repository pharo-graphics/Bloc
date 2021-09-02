Class {
	#name : 'BlDevScripterSpaceTarget',
	#superclass : 'BlDevScripterTarget',
	#category : 'Bloc-Scripter-Scripter-Targets'
}

{ #category : 'searching' }
BlDevScripterSpaceTarget >> findTargetIn: anElement [
	<return: #BlElement>
	self 
		assert: [ anElement isAttachedToSceneGraph ]
		description: [ 'Element must be in space' ].
	^ anElement space
]

{ #category : 'searching' }
BlDevScripterSpaceTarget >> findTargetStartingInScripter: aScripter [
	^ aScripter space
]

{ #category : 'accessing' }
BlDevScripterSpaceTarget >> identifier [
	^ 'space'
]

{ #category : 'printing' }
BlDevScripterSpaceTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Space'.
]
