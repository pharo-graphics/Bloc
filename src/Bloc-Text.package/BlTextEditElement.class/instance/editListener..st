controller
editListener: aBlTextEditListener
	"Set or change my edit listener.
	Note: there can be only one text edit listener assigned at a time,
	however nothing stops users from adding multiple event handler through
	a general even handler mechanism. One can even add more text edit listeners,
	however users would have to manage their change / replacement manually.
	New text edir listener must not be nil"
	self
		assert: [ aBlTextEditListener isNotNil ]
		description: [ 'Text edit listener must not be nil' ].
	
	self hasEditListener
		ifTrue: [ self removeEventHandler: self editListener ].
		
	editListener := aBlTextEditListener.
	self addEventHandler: aBlTextEditListener