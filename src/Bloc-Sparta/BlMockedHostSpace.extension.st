Extension { #name : #BlMockedHostSpace }

{ #category : #'*Bloc-Sparta' }
BlMockedHostSpace >> withSpartaRenderer [
	"create a surface of a specific type"
	surface := (BlSpartaSpaceRenderer pickSurfaceClassFor: self) new.

	"creates surfaceRenderer"
	surface initializeOn: self.

	"creates spaceRenderer"
	spaceRenderer := BlSpartaSpaceRenderer new.
	surface initializeOn: spaceRenderer
]
