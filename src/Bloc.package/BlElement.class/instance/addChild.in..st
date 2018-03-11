children add/remove
addChild: anElement in: aContainerName
	"Add a given element to a named container that must already exist"

	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChild: anElement. ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]