matrix - transforming points
transformPoint: aPoint
	| aX aY |
	
	aX := (aPoint x * sx) + (aPoint y * shx) + x.
	aY := (aPoint x * shy) + (aPoint y * sy) + y.
	
	^ aX @ aY