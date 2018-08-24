Extension { #name : #BrFontFamilyAttribute }

{ #category : #'*Bloc-Sparta' }
BrFontFamilyAttribute >> applyOnSpartaFontBuilder: aFontBuilder with: aSpartaSpan [
	aFontBuilder named: self name
]
