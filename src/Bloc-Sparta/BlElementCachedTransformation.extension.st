Extension { #name : #BlElementCachedTransformation }

{ #category : #'*Bloc-Sparta' }
BlElementCachedTransformation >> spartaMultiplyWith: aSpartaMatrix [
	"Multiple a given sparta matrix by my transformation only if I am not identity"

	self transformation isIdentity
		ifFalse: [ aSpartaMatrix multiplyBy: self matrix ]
]
