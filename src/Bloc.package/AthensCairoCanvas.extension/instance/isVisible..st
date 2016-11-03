*Bloc
isVisible: aRectangle
	"Return true if the given rectangle is (partially) visible"
	^ (currentClipRect ifNil: [ ^ true ]) intersects: aRectangle