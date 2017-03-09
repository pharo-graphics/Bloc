style - text
textForeground: aBlPaint
	self text: (self text copy attributes: { 
		BrTextForegroundAttribute paint: aBlPaint
	})