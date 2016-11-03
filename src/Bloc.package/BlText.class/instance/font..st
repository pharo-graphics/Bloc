accessing
font: aFont
	font := aFont.
	self updateTextModelFont.
	self invalidate.