event firing
fireAsBlurEvent: anEvent
	"Send blur event that doesn't bubble, perform simple direct dispatch to the target"
	self dispatchEvent: anEvent asBlurEvent target: anEvent target