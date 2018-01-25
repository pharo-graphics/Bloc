children add/remove
addChild: anElement as: aContainerName
	"Add a given element to my children and make it a named container, so that
	we could add children in that container"

	anElement userData at: #blocContainer put: aContainerName.
	self addChild: anElement