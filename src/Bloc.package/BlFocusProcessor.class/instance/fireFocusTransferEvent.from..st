event firing
fireFocusTransferEvent: anElement from: aPreviousFocusedElement
	"Send focus event that doesn't bubble, perform simple direct dispatch to the target"
	self
		dispatchEvent: (self newFocusTransferEvent
			target: anElement;
			transfer: aPreviousFocusedElement)
		target: anElement