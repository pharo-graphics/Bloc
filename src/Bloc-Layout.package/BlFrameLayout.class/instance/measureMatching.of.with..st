measure
measureMatching: theChildren of: anElement with: anExtentSpec
	theChildren
		ifEmpty: [ ^ self ].

	theChildren do: [ :aChildElement |
		self measureMatchingChild: aChildElement of: anElement with: anExtentSpec ]