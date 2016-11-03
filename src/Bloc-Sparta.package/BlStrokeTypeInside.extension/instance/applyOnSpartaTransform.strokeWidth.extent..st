*Bloc-Sparta
applyOnSpartaTransform: aTransform strokeWidth: aStrokeWidth extent: anExtent
	(aStrokeWidth isZero or: [ anExtent isZero ]) ifTrue: [ ^ self ].
	(anExtent x isZero or: [ anExtent y isZero ]) ifTrue: [ ^ self ].
	aTransform
		translateBy: (aStrokeWidth /2.0) asPoint;
		scaleBy: (anExtent x / (anExtent x + (aStrokeWidth))) @ (anExtent y / (anExtent y + (aStrokeWidth)))
		"scaleBy: ((1 - (aStrokeWidth / anExtent x)) @ (1 - (aStrokeWidth / anExtent y)))."
		
		