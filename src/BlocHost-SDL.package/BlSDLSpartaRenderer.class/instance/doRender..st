accessing
doRender: aSpace
	"collect the dirty area to be updated"
	dirtyAreas := self dirtyAreas 
			collect: [ :each | each intersect: (0@0 extent: self sdlSpace extent) ifNone: [ nil ] ]
			thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].
	dirtyAreas ifEmpty: [
		"If the window was exposed, present could be still needed."
		presentNeeded ifTrue: [
			self
				prepareForDrawing;
				present.
		].
		presentNeeded := false.
		^ self
	].
	
	self drawDuring: [:aCanvas| aSpace fullDrawOn: aCanvas ].
	
	self
		updateRectangles: dirtyAreas;
		present.
	presentNeeded := false.
	self clearDirtyAreasFor: aSpace