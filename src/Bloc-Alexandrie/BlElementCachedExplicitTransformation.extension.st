Extension { #name : #BlElementCachedExplicitTransformation }

{ #category : #'*Bloc-Alexandrie' }
BlElementCachedExplicitTransformation >> aeApplyTo: aeCanvas [

	self ensureMatrix.

	aeCanvas pathTransform:
		(BASharedCairoMatrix value
			beX: matrix x
			y: matrix y
			sx: matrix sx
			sy: matrix sy
			shx: matrix shx
			shy: matrix shy;
			yourself)
]
