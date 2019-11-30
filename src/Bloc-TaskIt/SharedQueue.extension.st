Extension { #name : #SharedQueue }

{ #category : #'*Bloc-TaskIt' }
SharedQueue >> itemArray [
	^ monitor critical: [ items asArray ]
]
