*Bloc-Sparta
spartaMultiplyWith: aSpartaMatrix
	self ensureMatrix.
	aSpartaMatrix isIdentity
		ifFalse: [ aSpartaMatrix multiplyBy: matrix ]