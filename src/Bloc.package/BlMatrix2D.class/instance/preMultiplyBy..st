matrix - transformations
preMultiplyBy: aMatrix2D
	| r11 r12 r21 r22 r31 r32 |

	r11 := (aMatrix2D sx * sx) + (aMatrix2D shy * shx).
	r12 := (aMatrix2D sx * shy) + (aMatrix2D shy * sy).
	r21 := (aMatrix2D shx * sx) + (aMatrix2D sy * shx).
	r22 := (aMatrix2D shx * shy) + (aMatrix2D sy * sy).
	r31 := (aMatrix2D x * sx) + (aMatrix2D y * shx) + x.
	r32 := (aMatrix2D x * shy) + (aMatrix2D y * sy) + y.

	sx := r11.
	shy := r12.
	shx := r21.
	sy := r22.
	x := r31.
	y := r32