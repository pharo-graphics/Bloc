Extension { #name : #BlElement }

{ #category : #'*BlocHost-Morphic' }
BlElement >> showNotification: anElement [
	parent notNil
		ifTrue: [ parent showNotification: anElement ]
		ifFalse: [ space showNotification: anElement ]
]
