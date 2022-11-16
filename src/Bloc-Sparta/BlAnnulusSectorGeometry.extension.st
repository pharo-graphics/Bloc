Extension { #name : #BlAnnulusSectorGeometry }

{ #category : #'*Bloc-Sparta' }
BlAnnulusSectorGeometry >> buildAnnulusSectorOnSpartaCanvas: aCanvas [
	"Assume innerRadius > 0"

	| aPathBuilder myCenter |
	myCenter := self center.

	aPathBuilder := aCanvas path absolute.

	aPathBuilder
		moveTo: myCenter;
		arcAround: myCenter
			radius: self absoluteOuterRadius
			startAngle: startAngleInRadians
			endAngle: endAngleInRadians;
		arcNegativeAround: myCenter
			radius: self absoluteInnerRadius
			startAngle: endAngleInRadians
			endAngle: startAngleInRadians;
		close.

	^ aPathBuilder build
]

{ #category : #'*Bloc-Sparta' }
BlAnnulusSectorGeometry >> buildCircleSectorOnSpartaCanvas: aCanvas [
	"Assume innerRadius = 0"

	| aPathBuilder |
	aPathBuilder := aCanvas path absolute.

	aPathBuilder
		moveTo: self center;
		arcAround: self center
			radius: self absoluteOuterRadius
			startAngle: startAngleInRadians
			endAngle: endAngleInRadians;
		lineTo: self center;
		close.

	^ aPathBuilder build
]

{ #category : #'*Bloc-Sparta' }
BlAnnulusSectorGeometry >> buildPathOnSpartaCanvas: aCanvas [

	^ self innerRadius = 0.0
		ifTrue: [ self buildCircleSectorOnSpartaCanvas: aCanvas ]
		ifFalse: [ self buildAnnulusSectorOnSpartaCanvas: aCanvas ]
]
