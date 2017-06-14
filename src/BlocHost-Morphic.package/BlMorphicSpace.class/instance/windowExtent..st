host space - accessing
windowExtent: anExtent
	
	"anExtent = renderer windowExtent
		ifTrue: [ ^ self ]."
	
	morphicWindow spaceExtent: anExtent