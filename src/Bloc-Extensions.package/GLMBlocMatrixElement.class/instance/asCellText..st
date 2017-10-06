instance creation
asCellText: aString

	^ (BrRopedText string: aString)
		attributes: {
			BrFontFamilyAttribute named: 'STIXGeneral' }