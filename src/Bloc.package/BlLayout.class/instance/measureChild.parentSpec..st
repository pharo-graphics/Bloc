private - measurement
measureChild: aChildElement parentSpec: anExtentSpec
	"Measure a given child element allowing it to take as much space within parent
	as it want *does not* taking child's margin and parent's padding into account.
	Note: You are only allowed to use me in a context of BlLayout and not from outside"

	self
		measureChild: aChildElement
		parentSpec: anExtentSpec
		widthUsed: 0
		heightUsed: 0