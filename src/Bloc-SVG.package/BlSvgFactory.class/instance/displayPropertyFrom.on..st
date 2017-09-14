properties
displayPropertyFrom: attributes on: aBlElement
	(attributes at:'display') = 'none' ifTrue:[ aBlElement visibility: BlVisibilityGone new ].