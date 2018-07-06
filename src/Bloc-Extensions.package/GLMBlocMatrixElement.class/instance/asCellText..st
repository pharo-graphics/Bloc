instance creation
asCellText: aString

	^ aString asRopedText
		attributes: {
			BrFontFamilyAttribute named: 'STIXGeneral' }