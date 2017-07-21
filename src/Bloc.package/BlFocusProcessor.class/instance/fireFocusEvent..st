event firing
fireFocusEvent: anElement
	"Send focus event that doesn't bubble, perform simple direct dispatch to the target"
	self
		dispatchEvent: (self newFocusEvent target: anElement)
		target: anElement