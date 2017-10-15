matrix - transformations
multiplyBy: aMatrix3D
	"Multiply me in-place by a given 3D Matrix"
	| _sx _shx0 _shx1 _x _shy0 _sy _shy1 _y _shz0 _shz1 _sz _z _wx _wy _wz _w |
	
	_sx := (sx * aMatrix3D sx) + (shy0 * aMatrix3D shx0) + (shz0 * aMatrix3D shx1) + (wx * aMatrix3D x).
	_shx0 := (shx0 * aMatrix3D sx) + (sy * aMatrix3D shx0) + (shz1 * aMatrix3D shx1) + (wy * aMatrix3D x).
	_shx1 := (shx1 * aMatrix3D sx) + (shy1 * aMatrix3D shx0) + (sz * aMatrix3D shx1) + (wz * aMatrix3D x).
	_x := (x * aMatrix3D sx) + (y * aMatrix3D shx0) + (z * aMatrix3D shx1) + (w * aMatrix3D x).

	_shy0 := (sx * aMatrix3D shy0) + (shy0 * aMatrix3D sy) + (shz0 * aMatrix3D shy1) + (wx * aMatrix3D y).
	_sy := (shx0 * aMatrix3D shy0) + (sy * aMatrix3D sy) + (shz1 * aMatrix3D shy1) + (wy * aMatrix3D y).
	_shy1 := (shx1 * aMatrix3D shy0) + (shy1 * aMatrix3D sy) + (sz * aMatrix3D shy1) + (wz * aMatrix3D y).
	_y := (x * aMatrix3D shy0) + (y * aMatrix3D sy) + (z * aMatrix3D shy1) + (w * aMatrix3D y).

	_shz0 := (sx * aMatrix3D shz0) + (shy0 * aMatrix3D shz1) + (shz0 * aMatrix3D sz) + (wx * aMatrix3D z).
	_shz1 := (shx0 * aMatrix3D shz0) + (sy * aMatrix3D shz1) + (shz1 * aMatrix3D sz) + (wy * aMatrix3D z).
	_sz := (shx1 * aMatrix3D shz0) + (shy1 * aMatrix3D shz1) + (sz * aMatrix3D sz) + (wz * aMatrix3D z).
	_z := (x * aMatrix3D shz0) + (y * aMatrix3D shz1) + (z * aMatrix3D sz) + (w * aMatrix3D z).

	_wx := (sx * aMatrix3D wx) + (shy0 * aMatrix3D wy) + (shz0 * aMatrix3D wz) + (wx * aMatrix3D w).
	_wy := (shx0 * aMatrix3D wx) + (sy * aMatrix3D wy) + (shz1 * aMatrix3D wz) + (wy * aMatrix3D w).
	_wz := (shx1 * aMatrix3D wx) + (shy1 * aMatrix3D wy) + (sz * aMatrix3D wz) + (wz * aMatrix3D w).
	_w := (x * aMatrix3D wx) + (y * aMatrix3D wy) + (z * aMatrix3D wz) + (w * aMatrix3D w).

	sx := _sx.
	shx0 := _shx0.
	shx1 := _shx1.
	x := _x.
	
	shy0 := _shy0.
	sy := _sy.
	shy1 := _shy1.
	y := _y.

	shz0 := _shz0.
	shz1 := _shz1.
	sz := _sz.
	z := _z.
	
	wx := _wx.
	wy := _wy.
	wz := _wz.
	w := _w