private
updateTextModelFont
	self font ifNil: [ ^ self ].
	textModel  attributes:
			{SpFontGenericFamilyAttribute sansSerif.
			(SpFontSizeAttribute size: self font size)}
		from: 1
		to: textModel size