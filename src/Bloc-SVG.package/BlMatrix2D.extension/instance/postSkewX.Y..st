*Bloc-SVG
postSkewX: aX Y: aY
	| tanX tanY |
	tanX := aX tan.
	tanY := aY tan.

	sx := tanY * shx + sx.
	shy := tanY * sy + shy.
	
	shx := tanX * sx + shx.
	sy :=  tanX * shy + sy.
	