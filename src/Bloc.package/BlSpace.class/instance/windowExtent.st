accessing
windowExtent
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"
	<return: #Point>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace windowExtent ]
		ifNil: [ extent ]