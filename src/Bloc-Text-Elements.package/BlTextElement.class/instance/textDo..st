accessing
textDo: aBlock
	"Perform a given block with my current text model as an argument and invalidate text"
	aBlock value: self text.
	self textChanged