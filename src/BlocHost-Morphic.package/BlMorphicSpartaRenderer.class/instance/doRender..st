renderer - rendering
doRender: aSpace

	"collect the dirty area to be updated"
	dirtyAreas := self dirtyAreas 
			collect: [ :each | each intersect: (0@0 extent: windowSize) ifNone: [ nil ] ]
			thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].

	dirtyAreas
		ifEmpty: [ ^ self ].
	
	morphicSpace lock critical: [ 
		aSpace fullDrawOn: spartaCanvas.
		self updateRectangles: dirtyAreas ].

	self clearDirtyAreasFor: aSpace