private - accessing
setExtent: anExtent
	"Actually change space and root extent to a given one"

	extent := anExtent.
	self root requestLayout