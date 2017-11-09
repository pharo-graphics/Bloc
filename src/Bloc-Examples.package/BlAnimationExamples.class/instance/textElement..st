instance creation
textElement: aCharacter
	| aText |
	
	aText := BrRopedText string: aCharacter asString.
	aText attributes: {
		BrFontSizeAttribute size: 90.
		BrFontFamilyAttribute named: 'Somatic' }.
	
	^ BlTextElement new text: aText