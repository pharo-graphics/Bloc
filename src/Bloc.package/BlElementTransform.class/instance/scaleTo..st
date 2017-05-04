scaling
scaleTo: aPoint
	"Define the scale factor using the given point.
	Note: aPoint may be a Point, a BlPoint3D or a BlockClosure that returns 
	one of the supported types."

	aPoint isPoint
		ifTrue: [ (aPoint isPoint2D )
			ifTrue: [ 
				self setScaleX: aPoint x Y: aPoint y ]
			ifFalse: [ self shouldBeImplemented ] ]
		ifFalse: [ self shouldBeImplemented ]