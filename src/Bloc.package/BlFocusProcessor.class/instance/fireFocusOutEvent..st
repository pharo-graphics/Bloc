event firing
fireFocusOutEvent: anElement
	"Send focusOut event that should bubble"

	self fireEvent: (self newFocusOutEvent target: anElement)