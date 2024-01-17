Extension { #name : 'RBPatternBlockToken' }

{ #category : '*Bloc-Text' }
RBPatternBlockToken >> acceptVisitor: aVisitor [

	^ aVisitor visitPatternBlockToken: self
]
