matrix - transforming points
transformPoint2D: aPoint2D
	| aX aY |
	
	aX := (aPoint2D x * sx) + (aPoint2D y * shx) + x.
	aY := (aPoint2D x * shy) + (aPoint2D y * sy) + y.
	
	^ aX @ aY