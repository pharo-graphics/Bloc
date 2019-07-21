Extension { #name : #TBlHostSpace }

{ #category : #'*Bloc-Sparta' }
TBlHostSpace >> withSpartaRenderer [
	renderer := BlSpartaRenderer new.
	renderer initializeHostSpace: self
]
