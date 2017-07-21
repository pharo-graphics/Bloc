event firing
fireBlurEvent: anElement
	"Create and send blur event that doesn't bubble, perform simple direct dispatch to the given target element"
	self
		dispatchEvent: (self newBlurEvent target: anElement)
		target: anElement