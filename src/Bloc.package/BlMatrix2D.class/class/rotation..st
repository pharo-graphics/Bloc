instance creation
rotation: anAngle
	"Return a matrix which corresponds to a rotation transformation by given angle"
	<return: #BlMatrix2D>
	| aMatrix aSin aCos |
	
	aMatrix := self new.
	aSin := anAngle sin reduce asFloat.
	aCos := anAngle cos reduce asFloat.
	
	aMatrix
		x: 0.0
		y: 0.0
		sx: aCos
		sy: aCos
		shx: aSin negated
		shy: aSin.

	^ aMatrix