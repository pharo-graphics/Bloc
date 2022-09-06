Extension { #name : #BlElementCachedExplicitTransformation }

{ #category : #'*Bloc-Sparta' }
BlElementCachedExplicitTransformation >> spartaMultiplyWith: aSpartaMatrix [
	"Multiple a given sparta matrix by my transformation only if I am not identity"

	elementTransformation isIdentity
		ifFalse: [ aSpartaMatrix multiplyBy: self matrix ]
]
