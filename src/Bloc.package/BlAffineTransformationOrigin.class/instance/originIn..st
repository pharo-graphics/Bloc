math
originIn: anElement
	"Return a point describing an origin of a transformation within a given element.
	Origin can be either a 2D or 3D points and should be given in local coordinates of the element"
	<return: #Point or: #BlPoint3D>

	^ self subclassResponsibility