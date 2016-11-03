*Bloc
multiplyBy: anAffineTransform

	"multiply receiver by given affine matrix"
"
| sx   shx   x   |        | sx'   shx'   x'   | 
| shy sy     y    |   *    | shy' sy'     y'   |
|  0     0     1   |        | 0  	0   		1	|       

"	
	
	| nsx nshx nx nshy nsy ny t |
	t := anAffineTransform asAthensAffineTransform.
	nsx := sx * t sx + (shx  * t shy).
	nshx := sx * t shx + (shx * t sy).
	nx := sx * t x + (shx * t y) + x.
	
	nshy := shy * t sx + (sy * t shy).
	nsy := shy * t shx  + (sy * t sy).
	ny := shy* t x + (sy * t y) + y.
	
	sx := nsx.
	sy := nsy.
	shx := nshx.
	shy := nshy.
	x := nx.
	y := ny.		