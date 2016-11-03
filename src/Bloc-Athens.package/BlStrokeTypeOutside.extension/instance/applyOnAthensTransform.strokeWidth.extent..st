*Bloc-Athens
applyOnAthensTransform: aTransform strokeWidth: aStrokeWidth extent: anExtent
	aTransform
		translateBy: (aStrokeWidth / 2.0) asPoint negated;
		scaleBy: (1 + (aStrokeWidth / anExtent x)) @ (1 + (aStrokeWidth / anExtent y))