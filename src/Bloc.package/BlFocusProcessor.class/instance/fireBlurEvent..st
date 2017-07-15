event firing
fireBlurEvent: anElement
	"Create and send blur event that doesn't bubble, perform simple direct dispatch to the given target element.
	Note: when dispatching events there is no need to attach target element to the event - it is anyway dispatched
	in the context of the target (bubbling does not happen)"
	self
		dispatchEvent: self newBlurEvent
		target: anElement