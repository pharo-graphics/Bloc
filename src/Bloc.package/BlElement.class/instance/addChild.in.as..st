children add/remove
addChild: anElement in: aContainerName as: aChildContainerName
	"Add a given element to a named container that must already exist
	and mark the added child as container too"

	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChild: anElement as: aChildContainerName ]
		ifNone: [ self error: 'Container named #', aContainerName asString, ' does not exist' ]