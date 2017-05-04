private
ensure2D
|ax|
	matrix2D ifNotNil: [ ^ self ].
	matrix2D := self defaultMatrix2D.
	
	ax := ((rotateAxis x * scaleX) @ (rotateAxis y * scaleY)) .
	
	matrix2D preTranslateX: translateX Y: translateY.
	rotateAngle isZero ifFalse: [ |rm|
		
		rm := BlMatrix2D new.
		rm preTranslateX:  ax x Y: ax y.
		rm preRotate: rotateAngle degreesToRadians.
		rm preTranslateX: ax x negated Y: ax y negated.
		matrix2D preMultiplyBy: rm.
		
			].
	
	 matrix2D preScaleX: scaleX Y: scaleY.
	
	