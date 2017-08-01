selection - handling
handleDeselected: anElement
	| anEvent |
	
	anEvent := BlElementSelectionLostEvent new.
	anEvent target: anElement.
	anElement dispatchEvent: anEvent