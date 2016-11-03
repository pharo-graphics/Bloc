private
updateTextModelFont
	self font ifNil: [ ^ self ].
	textModel  attributes:
			{SpFontGenericFamilyAttribute new sansSerif.
			(SpFontSizeAttribute size: self font pointSize)}
		from: 1
		to: textModel size