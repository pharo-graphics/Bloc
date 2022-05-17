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

{ #category : #'*Bloc-Sparta' }
BlFont >> asLogicalFont [ 

	^ LogicalFont
		familyName: self familyName
		fallbackFamilyNames: nil
		pointSize: self fontSize value
		stretchValue: self fontStretch value
		weightValue: self fontWeight value
		slantValue: self fontSlant value
]
