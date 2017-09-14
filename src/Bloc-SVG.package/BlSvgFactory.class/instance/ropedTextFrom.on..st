text
ropedTextFrom: node on: textElement
	|text textAttributes|
	text := BrRopedText string: node nodes first string trimBoth.
	
	textAttributes := OrderedCollection new.
	node attributes at:'font-family' ifPresent:[textAttributes add: (BrFontFamilyAttribute named: (node attributeAt:'font-family')) ].
	node attributes at:'font-size' ifPresent:[textAttributes add: (BrFontSizeAttribute size: (node attributeAt:'font-size') asNumber) ].
	node attributes at:'font-color' ifPresent:[textAttributes add: (BrTextForegroundAttribute paint: (self paintFrom: (node attributeAt:'font-color') on: textElement)) ].
	text attributes: textAttributes.
	
	textElement text: text