private - accessing
setExtent: anExtent
	"Actually change space, root and glass extent to a given one"

	extent := anExtent.
	self root requestLayout.
	self glass requestLayout