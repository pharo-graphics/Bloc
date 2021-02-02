Extension { #name : #BlFont }

{ #category : #'*Bloc-Sparta' }
BlFont >> applyOnSpartaFontBuilder: aFontBuilder [
	aFontBuilder
		named: self familyName;
		size: self fontSize value;
		weight: self fontWeight value;
		style: self fontSlant value;
		stretch: self fontStretch value
]
