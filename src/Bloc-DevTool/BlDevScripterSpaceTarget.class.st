Class {
	#name : #BlDevScripterSpaceTarget,
	#superclass : #BlDevScripterTarget,
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterSpaceTarget >> findTargetIn: anElement [
	<return: #BlElement>
	self 
		assert: anElement space isNotNil
		description: [ 'Element must be in space' ].
	^ anElement space
]

{ #category : #accessing }
BlDevScripterSpaceTarget >> identifier [
	^ 'space'
]

{ #category : #printing }
BlDevScripterSpaceTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Space'.
]
