children add/remove
removeChildrenIn: aContainerName
	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement removeChildren ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]