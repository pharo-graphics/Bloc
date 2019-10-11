Extension { #name : #BlGlutinHostSpace }

{ #category : #'*Bloc-Sparta' }
BlGlutinHostSpace >> withSpartaRenderer [
	renderer := BlSpartaRenderer new.
	renderer initializeForHostSpace: self
]
