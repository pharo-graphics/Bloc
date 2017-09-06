target detection
findTarget: anEvent
	"Find and return an appropriate element target for a given keyboard event.
	By default a keyboard event target is currently focused element if exists
	or space's root element otherwise.
	Note: target can not be nil"
	<return: #BlElement>

	^ self space focusProcessor hasFocusOwner
		ifTrue: [ self space focusProcessor focusOwner ]
		ifFalse: [ self space root ]