*Bloc-Core
by2D: aBlElementTransform translated: aPoint during: aBlock
	| needsTransformation needsTranslation  |

	needsTranslation := aPoint isZero not.
	needsTransformation := aBlElementTransform isIdentity not.
	
	(needsTransformation or: [ needsTranslation ])
		ifFalse: [ ^ aBlock value ].
	
	self during: [
		needsTranslation
			ifTrue: [ self translateBy: aPoint ].
			
		needsTransformation
			ifTrue: [ self multiplyBy: aBlElementTransform ].
			
		self apply.

		aBlock value ]