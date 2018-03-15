children add/remove
removeChild: anElement in: aContainerName
	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement removeChild: anElement ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]