Extension { #name : #TSpartaPathBuilder }

{ #category : #'*Bloc-SVG' }
TSpartaPathBuilder >> ellipticalArc: radii xrot: rotationAxis large: largeFlag sweep: sweepFlag to: aPoint [
	self explicitRequirement
]

{ #category : #'*Bloc-SVG' }
TSpartaPathBuilder >> reflectedCurveTo: aPoint [
	self explicitRequirement
]

{ #category : #'*Bloc-SVG' }
TSpartaPathBuilder >> reflectedCurveVia: aPoint to: anotherPoint [
	self explicitRequirement
]
