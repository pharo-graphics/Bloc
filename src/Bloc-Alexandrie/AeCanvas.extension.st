Extension { #name : #AeCanvas }

{ #category : #'*Bloc-Alexandrie' }
AeCanvas >> fullDraw: anElement [

	anElement aeFullDrawOn: self.
	self flush.
	
	^ #()
]
