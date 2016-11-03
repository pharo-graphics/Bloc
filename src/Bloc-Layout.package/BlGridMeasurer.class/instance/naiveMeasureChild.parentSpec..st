measure
naiveMeasureChild: aChildElement parentSpec: anExtentSpec

	self
		measureChild: aChildElement
		parentSpec: anExtentSpec
		widthResizer: aChildElement constraints horizontal resizer
		heightResizer: aChildElement constraints vertical resizer