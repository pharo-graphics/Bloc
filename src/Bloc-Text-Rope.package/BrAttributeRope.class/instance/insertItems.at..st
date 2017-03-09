rope - accessing
insertItems: aCollection at: anIndex

	^ self class attributeRope
		attributes: attributes
		rope: (rope insertItems: aCollection at: anIndex)