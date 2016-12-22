accessing
doRender: aSpace
	| aWindowScale |
	"collect the dirty area to be updated"
	dirtyAreas := self dirtyAreas 
			collect: [ :each | each intersect: (0@0 extent: self sdlSpace windowExtent) ifNone: [ nil ] ]
			thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].
	
	dirtyAreas ifEmpty: [
		"If the window was exposed, present could be still needed."
		presentNeeded ifTrue: [
			self
				prepareForDrawing;
				present ].
		presentNeeded := false.
		^ self ].
	
	"Damaged rectangles are defined in user coordinates (bloc space).
	We have to convert damage to window space, since we want to support high dpi displays"
	aWindowScale := self scaleFactor.
	dirtyAreas := dirtyAreas collect: [ :aRectangle | aRectangle scaleBy: aWindowScale ].
	
	self drawDuring: [:aCanvas| aSpace fullDrawOn: aCanvas ].
	
	self
		updateRectangles: dirtyAreas;
		present.
	presentNeeded := false.
	self clearDirtyAreasFor: aSpace