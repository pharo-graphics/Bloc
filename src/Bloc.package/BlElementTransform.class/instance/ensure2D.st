private
ensure2D
|ax|
	matrix ifNotNil: [ ^ self ].
	matrix := self defaultMatrix2D.
	
	ax := ((rotateAxis x * scaleX) @ (rotateAxis y * scaleY)) .
	matrix preTranslateX: translateX Y: translateY.
	rotateAngle isZero ifFalse: [ |rm|
		rm := BlMatrix2D new.
		"temp fix"
		matrix preTranslateX:  ax x Y: ax y.
		"rm preTranslateX:  ax x Y: ax y."
		rm preRotate: rotateAngle degreesToRadians.
		rm preTranslateX: ax x negated Y: ax y negated.
		matrix preMultiplyBy: rm.
		
			].
	 matrix preScaleX: scaleX Y: scaleY.
	
	