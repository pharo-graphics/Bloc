Extension { #name : #SpartaTransformationBuilder }

{ #category : #'*Bloc-Sparta' }
SpartaTransformationBuilder >> by2D: aBlElementTransform translated: aPoint during: aBlock [
	| needsTransformation needsTranslation  |

	needsTranslation := aPoint isZero not.
	needsTransformation := aBlElementTransform isIdentity not.
	
	(needsTransformation or: [ needsTranslation ])
		ifFalse: [ ^ aBlock value: self canvas ].
	
	self
		by: [ :aTransformationBuilder |
			aTransformationBuilder
				translateBy: aPoint;
				multiplyBy: aBlElementTransform ]
		during: [ aBlock value: self canvas ]
]

{ #category : #'*Bloc-Sparta' }
SpartaTransformationBuilder >> by3D: aBlElementTransform translated: aPoint during: aBlock [
	| aTransformedCanvas |
	
	aTransformedCanvas := self canvas similar: 200@400.
	aBlock value: aTransformedCanvas.

	self canvas stroke
			path: self canvas clip globalBounds;
			paint: Color black;
			draw.

	self
		by: [ :aTransformationBuilder | aTransformationBuilder translateBy: aPoint ]
		during: [
			self
				drawSurface: aTransformedCanvas surface
				transformed: aBlElementTransform matrix ]
]

{ #category : #'*Bloc-Sparta' }
SpartaTransformationBuilder >> by: aBlElementTransform translated: aPoint during: aBlock [

	aBlElementTransform is2D
		ifTrue: [ self by2D: aBlElementTransform translated: aPoint during: aBlock ]
		ifFalse: [ self by3D: aBlElementTransform translated: aPoint during: aBlock ]
]
