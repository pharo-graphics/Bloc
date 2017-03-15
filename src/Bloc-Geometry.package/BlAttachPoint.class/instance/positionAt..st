geometry
positionAt: aPoint
	"Move me so that my center is located at a given position"

	self position: (aPoint - (self extent / 2.0))