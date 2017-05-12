matrix - mathimatical functions
inverse
	"In-place inverse me.
	Throw BlSingularMatrixError if matrix is singular (non-invertible or degenerate)"
	| a b c d e f determinant inverseDeterminant |
	
	a := sy.
	b := shx negated.
	c := (shx * y) - (sy * x).
	d := shy negated.
	e := sx.
	f := (x * shy) - (sx * y).
	
	determinant := self determinant.
	determinant isZero
		ifTrue: [ BlSingularMatrixError signal: 'Matrix is singular and can not be inverted!' ].
		
	inverseDeterminant := 1.0 / determinant.
	
	sx := inverseDeterminant * a.
	shy := inverseDeterminant * d.
	shx := inverseDeterminant * b.
	sy := inverseDeterminant * e.
	x := inverseDeterminant * c.
	y := inverseDeterminant * f