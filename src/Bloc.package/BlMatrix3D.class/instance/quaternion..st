initialization
quaternion: aQuaternion
	"Set me to be a rotation matrix defined by a given quaternion"
	| normalized x2 y2 z2 xx xy xz yy yz zz _wx _wy _wz |

	"normalized quaternion"
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

	_wx := normalized w * x2.
	_wy := normalized w * y2.
	_wz := normalized w * z2.
	
	sx := (self class flushToZero: 1.0 - (yy + zz)).
	shy0 := (self class flushToZero: xy - _wz).
	shz0 := (self class flushToZero: xz + _wy).
	wx := 0.0.
	shx0 := (self class flushToZero: xy + _wz).
	sy := (self class flushToZero: 1.0 - (xx + zz)).
	shz1 := (self class flushToZero: yz - _wx).
	wy := 0.0.
	shx1 := (self class flushToZero: xz - _wy).
	shy1 := (self class flushToZero: yz + _wx).
	sz := (self class flushToZero: 1.0 - (xx + yy)).
	wz := 0.0.
	x := 0.0.
	y := 0.0.
	z := 0.0.
	w := 1.0.