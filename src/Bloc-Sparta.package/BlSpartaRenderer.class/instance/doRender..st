renderer - rendering
doRender: aSpace
	| theDirtyAreas |
	
	"collect the dirty area to be updated"
	theDirtyAreas := aSpace dirtyAreas 
			collect: [ :each | each intersect: (0@0 extent: windowExtent) ifNone: [ nil ] ]
			thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].

	theDirtyAreas
		ifEmpty: [ ^ self ].

	aSpace fullDrawOn: spartaCanvas.
	self presentAreas: theDirtyAreas