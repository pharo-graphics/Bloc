Extension { #name : #RBToken }

{ #category : #'*Bloc-Text' }
RBToken >> acceptVisitor: aVisitor [

	(self class name, '>>acceptVisitor: not implemented') traceCr.
	^ aVisitor visitToken: self
]
