Extension { #name : #SpartaTransformationBuilder }

{ #category : #'*Bloc-Sparta' }
SpartaTransformationBuilder >> by: aMatrix translated: aPoint during: aBlock [
	| needsTransformation needsTranslation  |

	needsTranslation := aPoint isZero not.
	needsTransformation := aMatrix isIdentity not.
	
	(needsTransformation or: [ needsTranslation ])
		ifFalse: [ ^ aBlock value: self canvas ].
	
	self
		by: [ :aTransformationBuilder |
			needsTranslation ifTrue: [ aTransformationBuilder translateBy: aPoint ].
			needsTransformation ifTrue: [ aTransformationBuilder multiplyBy: aMatrix ] ]
		during: [ aBlock value: self canvas ]
]
