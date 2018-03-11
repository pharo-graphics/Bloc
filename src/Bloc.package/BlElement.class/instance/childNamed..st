children accessing
childNamed: aChildName
	<return: #BlElement>

	self
		childNamed: aChildName
		ifFound: [ :anElement | ^ anElement ]
		ifNone: [ self error: 'Children container named ', aChildName asString, ' does not exist' ]