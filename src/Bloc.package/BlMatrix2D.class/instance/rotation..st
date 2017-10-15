initialization
rotation: anAngle
	"Set me to be a 2D matrix representing a rotation by a given angle in radians"
	| aMatrix aSin aCos |

	aMatrix := self new.
	aSin := anAngle sin reduce asFloat.
	aCos := anAngle cos reduce asFloat.
	
	x := 0.0.
	y := 0.0.
	sx := aCos.
	sy := aCos.
	shx := aSin negated.
	shy := aSin