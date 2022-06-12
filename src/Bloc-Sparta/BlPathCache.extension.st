Extension { #name : #BlPathCache }

{ #category : #'*Bloc-Sparta' }
BlPathCache >> pathOnSpartaCanvas: aCanvas [
	self checkSession.
	self checkIdentity: aCanvas.

	^ geometryPath ifNil: [
		canvasIdentity := aCanvas identity.
		geometryPath := self geometry buildPathOnSpartaCanvas: aCanvas ]
]

{ #category : #'*Bloc-Sparta' }
BlPathCache >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>

	^ strokedBounds ifNil: [ strokedBounds := anElement outskirts strokedBounds: BlBounds new of: anElement on: aCanvas ]
]
