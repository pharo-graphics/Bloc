Extension { #name : #SpartaTransformationBuilder }

{ #category : #'*Bloc-Sparta' }
SpartaTransformationBuilder >> by: aBlElementTransform translated: aPoint during: aBlock [
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
