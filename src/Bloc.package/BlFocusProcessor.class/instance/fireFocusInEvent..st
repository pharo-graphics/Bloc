event firing
fireFocusInEvent: anElement
	"Send focusIn event that should bubble"

	self fireEvent: (self newFocusInEvent target: anElement)