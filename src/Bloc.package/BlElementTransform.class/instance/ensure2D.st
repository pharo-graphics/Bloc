private
ensure2D
|rAxis|
	matrix ifNotNil: [ ^ self ].
	matrix := self defaultMatrix2D.
	
	rAxis := ((rotateAxis x * scaleX) @ (rotateAxis y * scaleY)) .
	
	matrix preTranslateX: translateX Y: translateY.
	rotateAngle isZero ifFalse: [ |rm|
		
		rm := BlMatrix2D new.
		rm preTranslateX: rAxis x Y: rAxis y.
		rm preRotate: rotateAngle degreesToRadians.
		rm preTranslateX: rAxis x negated Y: rAxis y negated.
		matrix preMultiplyBy: rm.
		
			].
	 matrix preScaleX: scaleX Y: scaleY.
	
	