Extension { #name : #BlTextDecorationCompositeType }

{ #category : #'*Bloc-Sparta' }
BlTextDecorationCompositeType >> asSkiaDecorationType [
	^ types
		inject: SkiaTextDecorationType NoDecoration value
		into: [ :sum :each | sum | each asSkiaDecorationType ]
]
