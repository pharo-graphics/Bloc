children add/remove
addChildren: aListOfElements in: aContainerName
	"Add given elements to a named container that must already exist"

	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChildren: aListOfElements. ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]