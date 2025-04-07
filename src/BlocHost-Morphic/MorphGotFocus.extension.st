Extension { #name : #MorphGotFocus }

{ #category : #'*BlocHost-Morphic' }
MorphGotFocus >> sentTo: anObject [

	^ anObject handleMorphGotFocus: self
]
