event firing
fireAsFocusOutEvent: anEvent
	"Send focusOut event that should bubble"
	self fireEvent: anEvent asFocusOutEvent