Extension { #name : #MorphDeleted }

{ #category : #'*BlocHost-Morphic' }
MorphDeleted >> sentTo: anObject [

	^ anObject handleMorphDeleted: self
]
