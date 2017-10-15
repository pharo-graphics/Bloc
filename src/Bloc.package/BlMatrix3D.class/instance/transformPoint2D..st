matrix - transforming points
transformPoint2D: aPoint2D
	<return: #BlPoint2D>
	| aX aY aW |
	
	aX := (aPoint2D x * sx) + (aPoint2D y * shx0) + x.
	aY := (aPoint2D x * shy0) + (aPoint2D y * sy) + y.
	aW := (aPoint2D x * wx) + (aPoint2D y * wy) + w.

	^ BlPoint2D
		x: aX asFloat / aW
		y: aY asFloat / aW