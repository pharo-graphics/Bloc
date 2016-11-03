drawing
fullDrawOnAthensCanvas: aCanvas
	
	(self isVisible and: [ self isInDirtyAreas ])
		ifFalse: [ ^ self ].
		
	aCanvas pathTransform restoreAfter: [ 
			aCanvas pathTransform multiplyBy: self transform.
			aCanvas 
				preservingClipByLocal: self boundsInLocal
				global: self boundsInSpace
				during:[	self drawOn: aCanvas ]].
	self dirty: false