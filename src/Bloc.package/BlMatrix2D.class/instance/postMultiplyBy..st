transformations
postMultiplyBy: aMatrix2D
	| r11 r12 r21 r22 r31 r32 |
	
	r11 := (a11 * aMatrix2D a11) + (a12 * aMatrix2D a21).
	r12 := (a11 * aMatrix2D a12) + (a12 * aMatrix2D a22).
	r21 := (a21 * aMatrix2D a11) + (a22 * aMatrix2D a21).
	r22 := (a21 * aMatrix2D a12) + (a22 * aMatrix2D a22).
	r31 := (a31 * aMatrix2D a11) + (a32 * aMatrix2D a21) + aMatrix2D a31.
	r32 := (a31 * aMatrix2D a12) + (a32 * aMatrix2D a22) + aMatrix2D a32.

	a11 := r11.
	a12 := r12.
	a21 := r21.
	a22 := r22.
	a31 := r31.
	a32 := r32