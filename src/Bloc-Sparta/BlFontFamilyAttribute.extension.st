Extension { #name : #BlFontFamilyAttribute }

{ #category : #'*Bloc-Sparta' }
BlFontFamilyAttribute >> applyOnSpartaFontBuilder: aFontBuilder with: aSpartaSpan [
	aFontBuilder named: self name
]
