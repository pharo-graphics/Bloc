children add/remove
addChildFirst: anElement as: aContainerName
	"Add a given element as my first child and make it a named container, so that
	we could add children in that container"

	anElement userData at: #blocContainer put: aContainerName.
	self addChildFirst: anElement