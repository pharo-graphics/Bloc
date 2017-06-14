geometry
extent
	"Return actual extent of the underlying surface.
	Note: between frames #extent may be different from canvas or window extents because
	those two methods return immediate/current window extent by asking host window directly"
	<return: #Point>

	^ self subclassResponsibility