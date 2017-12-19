measure
measure: anElement with: anExtentSpec
	
	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ].

	self measureIgnored: anElement with: anExtentSpec.
	self measurePositions: anElement with: anExtentSpec.
	
	self fit: anElement with: anExtentSpec