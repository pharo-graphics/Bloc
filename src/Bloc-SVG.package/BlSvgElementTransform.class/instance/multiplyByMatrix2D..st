matrix transformation
multiplyByMatrix2D: aBlMatrix2D
	self ensureMatrix.
	matrix postMultiplyBy: aBlMatrix2D.
	
	self setTranslateX: matrix x Y: matrix y Z: 0
		AndScaleX: matrix sx Y: matrix sy Z: 0
		AndSkewX: matrix shx Y: matrix shy Z: 0.