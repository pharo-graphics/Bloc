matrix - transforming points
transformPoint4D: aPoint4D
	<return: #BlPoint4D>
	| aX aY aZ aW |
	
	aX := (aPoint4D x * sx) + (aPoint4D y * shx0) + (aPoint4D z * shx1) + (aPoint4D w * x).
	aY := (aPoint4D x * shy0) + (aPoint4D y * sy) + (aPoint4D z * shy1) + (aPoint4D w * y).
	aZ := (aPoint4D x * shz0) + (aPoint4D y * shz1) + (aPoint4D z * sz) + (aPoint4D w * z).
	aW := (aPoint4D x * wx) + (aPoint4D y * wy) + (aPoint4D z * wz) + (aPoint4D w * w).

	^ BlPoint4D
		x: aX
		y: aY
		z: aZ
		w: aW