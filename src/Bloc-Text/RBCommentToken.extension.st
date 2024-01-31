Extension { #name : 'RBCommentToken' }

{ #category : '*Bloc-Text' }
RBCommentToken >> acceptVisitor: aVisitor [

	^ aVisitor visitCommentToken: self
]
