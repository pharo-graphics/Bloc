accessing
position: aPoint
	position := aPoint.
	self hostSpace ifNotNil: [ :aHostSpace | 
			aHostSpace position = aPoint
				ifFalse: [ aHostSpace position: aPoint ].
			"when host window moves around it may end up on a different
			display with other dpi. We have to detect dpi change and
			perform window resize operation. As result it will create
			a new rendering canvas with different size"
			aHostSpace hasResized
				ifTrue: [
					self windowExtent: aHostSpace windowExtent.
					"space resized, let's redraw"
					self beDirtyArea ] ]