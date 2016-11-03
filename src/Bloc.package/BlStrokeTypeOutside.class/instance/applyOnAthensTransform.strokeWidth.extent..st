applying
applyOnAthensTransform: aTransfrom strokeWidth: aStrokeWidth extent: anExtent
	aTransfrom
		translateBy: (aStrokeWidth / 2.0) asPoint negated;
		scaleBy: (1 + (aStrokeWidth / anExtent x)) @ (1 + (aStrokeWidth / anExtent y))