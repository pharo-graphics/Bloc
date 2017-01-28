geometry
spaceExtent
	| aDelta |
	
	"we compute decorations extent first"
	aDelta := self fullBounds extent - spaceForm extent.
	^ self extent - aDelta