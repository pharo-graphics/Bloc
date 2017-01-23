instance creation
rotation: anAngle
	"Return a matrix which corresponds to rotation matrix by given angle"
	<return: #BlMatrix2D>
	| aMatrix aSin aCos |
	
	aMatrix := self new.
	aSin := anAngle sin reduce asFloat.
	aCos := anAngle cos reduce asFloat.

	aMatrix
		a11: aCos
		a12: aSin
		a21: aSin negated
		a22: aCos
		a31: 0.0
		a32: 0.0.

	^ aMatrix