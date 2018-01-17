accessing
windowExtent: anExtent
	"Request to change a window size to aNewExtent.
	Note, that window size may be different from renderer size on high dpi (retina) displays"

	self hasHostSpace
		ifTrue: [ self hostSpace windowExtent: anExtent ]
		ifFalse: [ self setExtent: anExtent ]