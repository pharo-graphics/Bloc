*Bloc-Sparta
spartaMultiplyWith: aSpartaMatrix
	self ensure2D.
	aSpartaMatrix isIdentity
		ifFalse: [ aSpartaMatrix multiplyBy: matrix2D ]