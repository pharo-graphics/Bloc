Extension { #name : #AeCanvas }

{ #category : #'*Bloc-Alexandrie' }
AeCanvas >> fullDraw: anElement [

	anElement aeDrawOn: self.
	self flush.
	
	^ #()
]
