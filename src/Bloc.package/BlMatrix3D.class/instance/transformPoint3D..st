matrix - transforming points
transformPoint3D: aPoint3D
	<return: #BlPoint3D>
	| aX aY aZ aW |
	
	aX := (aPoint3D x * sx) + (aPoint3D y * shx0) + (aPoint3D z * shx1) + x.
	aY := (aPoint3D x * shy0) + (aPoint3D y * sy) + (aPoint3D z * shy1) + y.
	aZ := (aPoint3D x * shz0) + (aPoint3D y * shz1) + (aPoint3D z * sz) + z.
	aW := (aPoint3D x * wx) + (aPoint3D y * wy) + (aPoint3D z * wz) + w.

	^ BlPoint3D
		x: aX asFloat / aW
		y: aY asFloat / aW
		z: aZ asFloat / aW