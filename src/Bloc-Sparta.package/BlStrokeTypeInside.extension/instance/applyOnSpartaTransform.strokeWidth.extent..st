*Bloc-Sparta
applyOnSpartaTransform: aTransform strokeWidth: aStrokeWidth extent: anExtent
	| aWidth aHeight |

	aWidth := anExtent x asFloat.
	aHeight := anExtent y asFloat.

	(aStrokeWidth isZero or: [ aWidth isZero or: [ aHeight isZero ] ])
		ifTrue: [ ^ self ].

	aTransform
		translateX: (aStrokeWidth / 2.0) Y: (aStrokeWidth / 2.0) ;
		scaleX: aWidth / (aWidth + aStrokeWidth) Y: aHeight / (aHeight + aStrokeWidth)