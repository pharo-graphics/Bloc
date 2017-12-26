installation
onInstalledIn: anElement
	super onInstalledIn: anElement.
	
	widget := anElement.
	widget removeChildren.
	self initializeSkin.

	widget isActivated
		ifTrue: [ self switchActivated ]
		ifFalse: [ self switchDeactivated ]