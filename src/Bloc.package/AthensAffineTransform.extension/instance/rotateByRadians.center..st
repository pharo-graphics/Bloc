*Bloc
rotateByRadians: angle center: aPoint

	| cos sin newSx newSy |
	
	cos := angle cos.
	sin := angle sin.
	
	newSx := sx*cos + (shx*sin).
	newSy := sy*cos - (shy*sin).
	
	shx := shx*cos - (sx*sin).
	shy := shy*cos + (sy*sin).

	sx := newSx.
	sy := newSy.