change reporting
textChanged
	"text layout is no more valid, remove it"
	paragraph := nil.

	"request redraw and layout"
	self requestLayout.
	self invalidate