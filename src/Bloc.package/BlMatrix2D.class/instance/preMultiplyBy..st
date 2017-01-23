transformations
preMultiplyBy: aMatrix2D
	| r11 r12 r21 r22 r31 r32 |

	r11 := (aMatrix2D a11 * a11) + (aMatrix2D a12 * a21).
	r12 := (aMatrix2D a11 * a12) + (aMatrix2D a12 * a22).
	r21 := (aMatrix2D a21 * a11) + (aMatrix2D a22 * a21).
	r22 := (aMatrix2D a21 * a12) + (aMatrix2D a22 * a22).
	r31 := (aMatrix2D a31 * a11) + (aMatrix2D a32 * a21) + a31.
	r32 := (aMatrix2D a31 * a12) + (aMatrix2D a32 * a22) + a32.

	a11 := r11.
	a12 := r12.
	a21 := r21.
	a22 := r22.
	a31 := r31.
	a32 := r32