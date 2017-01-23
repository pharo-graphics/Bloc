transforming points
transformPoint: aPoint
	| aX aY |
	
	aX := (aPoint x * a11) + (aPoint y * a21) + a31.
	aY := (aPoint x * a12) + (aPoint y * a22) + a32.
	
	^ aX @ aY