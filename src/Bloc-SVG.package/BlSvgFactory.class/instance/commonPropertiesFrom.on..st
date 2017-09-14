properties
commonPropertiesFrom: attributes on: aBlElement
	aBlElement outskirts: BlOutskirts centered.
	aBlElement layout: BlSvgGroupLayout new.
	
	attributes at:'display' ifPresent: [ self displayPropertyFrom: attributes on: aBlElement ].
	
	attributes at:'id' ifPresent: [ aBlElement svgName: (attributes at: 'id').
		self idHandlingFrom: attributes on: aBlElement. ]
	