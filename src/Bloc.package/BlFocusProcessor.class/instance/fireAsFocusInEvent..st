event firing
fireAsFocusInEvent: anEvent
	"Send focusIn event that should bubble"
	self fireEvent: anEvent asFocusInEvent