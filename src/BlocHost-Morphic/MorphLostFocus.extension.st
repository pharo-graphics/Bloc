Extension { #name : #MorphLostFocus }

{ #category : #'*BlocHost-Morphic' }
MorphLostFocus >> sentTo: anObject [

	^ anObject handleMorphLostFocus: self
]
