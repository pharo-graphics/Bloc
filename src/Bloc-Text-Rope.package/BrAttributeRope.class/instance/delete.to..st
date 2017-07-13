rope - deleting
delete: aStart to: anEnd

	^ self class attributeRope
		attributes: attributes
		rope: (rope delete: aStart to: anEnd)