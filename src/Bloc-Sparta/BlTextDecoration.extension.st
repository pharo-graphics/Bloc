Extension { #name : #BlTextDecoration }

{ #category : #'*Bloc-Sparta' }
BlTextDecoration >> applyOnSkiaDecoration: aSkiaTextDecoration [
	aSkiaTextDecoration
		color: self color;
		thickness: self thickness;
		mode: SkiaTextDecorationMode Through.

	self type applyOnSkiaDecoration: aSkiaTextDecoration.
	self style applyOnSkiaDecoration: aSkiaTextDecoration
]
