Extension { #name : #BlTransformation }

{ #category : #'*Bloc-Sparta' }
BlTransformation >> spartaMultiplyWith: aSpartaMatrix [

	self hasMatrix
		ifFalse: [ ^ self ].
		
	self is2D
		ifTrue: [ 
			self ensure2D.
			aSpartaMatrix isIdentity
				ifFalse: [ aSpartaMatrix multiplyBy: matrix2D ] ]
		ifFalse: [ self error: 'Multiplication with 2D Sparta matrix is unsupported for 3D transformations' ]
]
