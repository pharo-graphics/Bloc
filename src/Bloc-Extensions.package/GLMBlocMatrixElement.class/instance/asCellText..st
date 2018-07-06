instance creation
asCellText: aString

	^ (BlRopedText string: aString)
		attributes: {
			BrFontFamilyAttribute named: 'STIXGeneral' }