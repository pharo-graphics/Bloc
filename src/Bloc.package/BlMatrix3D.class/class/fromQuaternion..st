instance creation
fromQuaternion: aQuaternion
	"Return a new 3D rotation matrix from a given rotation quaternion"
	<return: #BlMatrix3D>
	"normalized quaternion"
	| normalized x2 y2 z2 xx xy xz yy yz zz wx wy wz |
	
	normalized := aQuaternion normalized.

	x2 := normalized x + normalized x.
	y2 := normalized y + normalized y.
	z2 := normalized z + normalized z.

	xx := normalized x * x2.
	xy := normalized x * y2.
	xz := normalized x * z2.

	yy := normalized y * y2.
	yz := normalized y * z2.
	zz := normalized z * z2.

	wx := normalized w * x2.
	wy := normalized w * y2.
	wz := normalized w * z2.
	
	^ self new
		sx: (self flushToZero: 1.0 - (yy + zz))
		shy0: (self flushToZero: xy - wz)
		shz0: (self flushToZero: xz + wy)
		wx: 0.0
		shx0: (self flushToZero: xy + wz)
		sy: (self flushToZero: 1.0 - (xx + zz))
		shz1: (self flushToZero: yz - wx)
		wy: 0.0;
		shx1: (self flushToZero: xz - wy)
		shy1: (self flushToZero: yz + wx)
		sz: (self flushToZero: 1.0 - (xx + yy))
		wz: 0.0
		x: 0.0
		y: 0.0
		z: 0.0
		w: 1.0