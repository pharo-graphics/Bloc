host space - accessing
windowExtent: anExtent
	
	anExtent = renderer windowSize
		ifTrue: [ ^ self ].
	
	morphicWindow spaceExtent: anExtent.
	renderer resetResources