mathimatical functions
inverse
	"In-place inverse me.
	Throw BlSingularMatrixError if matrix is singular (non-invertible or degenerate)"
	| a b c d e f determinant inverseDeterminant |
	
	a := a22.
	b := a21 negated.
	c := (a21 * a32) - (a22 * a31).
	d := a12 negated.
	e := a11.
	f := (a31 * a12) - (a11 * a32).
	
	determinant := self determinant.
	determinant isZero
		ifTrue: [ BlSingularMatrixError signal: 'Matrix is singular and can not be inverted!' ].
		
	inverseDeterminant := 1.0 / determinant.
	
	a11 := inverseDeterminant * a.
	a12 := inverseDeterminant * d.
	a21 := inverseDeterminant * b.
	a22 := inverseDeterminant * e.
	a31 := inverseDeterminant * c.
	a32 := inverseDeterminant * f