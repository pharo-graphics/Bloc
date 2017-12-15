showing / hiding
showOn: anElement

	"we don't want to add selection to the root element"
	anElement isRoot
		ifTrue: [ ^ self ].

	self
		assert: [ client isNil ]
		description: [ 'Can not assign selection to multiple elements!' ].

	self
		assert: [ self hasParent not ]
		description: [ 'I must not have parent' ].

	client := anElement.
	client addEventHandler: clientListener.
	client space root addChild: self.
	
	self relocate: self selectionPosition.
	self size: self selectionExtent.