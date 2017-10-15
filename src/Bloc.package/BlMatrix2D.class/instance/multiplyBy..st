matrix - transformations
multiplyBy: aMatrix2D
	"Perform a right multiplication by a given 2D matrix"
	| r11 r12 r21 r22 r31 r32 |
	
	r11 := (sx * aMatrix2D sx) + (shy * aMatrix2D shx).
	r12 := (sx * aMatrix2D shy) + (shy * aMatrix2D sy).
	r21 := (shx * aMatrix2D sx) + (sy * aMatrix2D shx).
	r22 := (shx * aMatrix2D shy) + (sy * aMatrix2D sy).
	r31 := (x * aMatrix2D sx) + (y * aMatrix2D shx) + aMatrix2D x.
	r32 := (x * aMatrix2D shy) + (y * aMatrix2D sy) + aMatrix2D y.

	sx := r11.
	shy := r12.
	shx := r21.
	sy := r22.
	x := r31.
	y := r32