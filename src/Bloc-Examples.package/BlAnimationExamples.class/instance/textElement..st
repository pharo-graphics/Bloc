accessing
textElement: aCharacter
	| aText |
	
	aText := BlRopedText string: aCharacter asString.
	aText attributes: {
		BrFontSizeAttribute size: 90.
"		BrTextBackgroundAttribute paint: (Color white alpha: 0.5)."
		BrFontFamilyAttribute named: "'Bauhaus 93'" "'Curlz MT'" 'Phosphate' }.
	
	^ BlTextElement new 
		text: aText;
		effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 20 offset: 0@0)