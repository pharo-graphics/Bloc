*Bloc-Sparta
spartaMultiplyWith: aSpartaMatrix
	"Multiple a given sparta matrix by my transformation only if I am not identity"

	self isIdentity
		ifFalse: [ aSpartaMatrix multiplyBy: self matrix ]