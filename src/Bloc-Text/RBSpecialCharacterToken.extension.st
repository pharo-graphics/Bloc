Extension { #name : #RBSpecialCharacterToken }

{ #category : #'*Bloc-Text' }
RBSpecialCharacterToken >> acceptVisitor: aVisitor [

	^ aVisitor visitSpecialCharacterToken: self
]
