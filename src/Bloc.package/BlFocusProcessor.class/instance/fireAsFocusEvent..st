event firing
fireAsFocusEvent: anEvent
	"Send focus event that doesn't bubble, perform simple direct dispatch to the target"
	self dispatchEvent: anEvent asFocusEvent target: anEvent target