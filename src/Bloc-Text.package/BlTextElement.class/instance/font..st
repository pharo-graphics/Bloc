style - font
font: aLogicalFont
	self text: (self text copy attributes: {
		BrFontWeightAttribute weight: aLogicalFont weightValue.
	})