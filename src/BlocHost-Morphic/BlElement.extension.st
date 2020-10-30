Extension { #name : #BlElement }

{ #category : #'*BlocHost-Morphic' }
BlElement >> showNotification: aNotification [
	parent notNil
		ifTrue: [ parent showNotification: aNotification ]
		ifFalse: [
			self isAttachedToSceneGraph
				ifTrue: [ self space showNotification: aNotification ] ]
]
