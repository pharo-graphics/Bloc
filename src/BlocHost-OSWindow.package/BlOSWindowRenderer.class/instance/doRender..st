rendering
doRender: aSpace
	"collect the dirty area to be updated"
	dirtyAreas := self dirtyAreas 
			collect: [ :each | each intersect: (0@0 extent: renderer window extent) ifNone: [ nil ] ]
			thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].
	dirtyAreas ifEmpty: [
		"If the window was exposed, present could be still needed."
		presentNeeded ifTrue: [
			renderer
				prepareForDrawing;
				present.
		].
		presentNeeded := false.
		^ self
	].
	
	renderer drawDuring: [:aCanvas| aSpace fullDrawOn: aCanvas ].
	
	renderer
		presentAreas: dirtyAreas;
		present.
	presentNeeded := false