matrix - mathematical functions
decomposition
	"Decompose this 2D Matrix into components and return a resulting decomposition.
	Based on https://drafts.csswg.org/css-transforms/#decomposing-a-2d-matrix"
	<return: #BlMatrixDecomposition2D>
	
	| row0x row0y row1x row1y scaleX scaleY translate determinant angle matrix |
	
	row0x := self sx.
	row0y := self shy.
	row1x := self shx.
	row1y := self sy.
	
	translate := BlVector x: self x y: self y z: 0.
	scaleX := ((row0x * row0x) + (row0y * row0y)) sqrt.
	scaleY := ((row1x * row1x) + (row1y * row1y)) sqrt.
	
	determinant := (row0x * row1y) - (row0y * row1x).
	"If determinant is negative, one axis was flipped."
	determinant < 0
		ifTrue: [ 
			row0x < row1y
				ifTrue: [ scaleX := scaleX negated ]
				ifFalse: [ scaleY := scaleY negated ] ].
	
	"Renormalize matrix to remove scale."
	scaleX isZero
		ifFalse: [
			row0x := row0x * (1.0 / scaleX).
			row0y := row0y * (1.0 / scaleX) ].
	scaleY isZero
		ifFalse: [
			row1x := row1x * (1.0 / scaleY).
			row1y := row1y * (1.0 / scaleY) ].
	
	"Compute rotation and renormalize matrix."
	angle := row0y arcTan: row0x.
	angle isZero
		ifFalse: [ 
			| sn cs m11 m12 m21 m22 |
			sn := row0y negated.
			cs := row0x.
			m11 := row0x.
			m12 := row0y.
			m21 := row1x.
			m22 := row1y.
			row0x := (cs * m11) + (sn * m21).
			row0y := (cs * m12) + (sn * m22).
			row1x := (sn negated * m11) + (cs * m21).
			row1y := (sn negated * m12) + (cs * m22) ].
	
	matrix := Matrix
		rows: 2
		columns: 2
		contents: { row0x . row0y . row1x . row1y }.
		
	"Convert into degrees because our rotation functions expect it."
	angle := angle radiansToDegrees.
	
	^ BlMatrixDecomposition2D new
		translation: translate;
		scale: (BlVector x: scaleX y: scaleY z: 1);
		angle: angle;
		matrix: matrix