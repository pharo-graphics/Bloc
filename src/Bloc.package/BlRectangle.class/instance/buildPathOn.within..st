path building
buildPathOn: aPathBuilder within: aBounds
	| x y w h min tlr trr blr brr |
	w := aBounds extent x.
	h := aBounds extent y.
	x := aBounds origin x.
	y := aBounds origin y.
	min := ((x + w) min: (y+h)) / 2.
	tlr := cornerRadii topLeft min: min.
	trr := cornerRadii topRight min: min.
	brr := cornerRadii bottomRight min: min.
	blr := cornerRadii bottomLeft min: min.
	aPathBuilder
		absolute;
		moveTo: x @ tlr;
		cwArcTo: tlr @ y angle: Float pi / 2;
		lineTo: (x + w - trr) @ y;
		cwArcTo: (x + w) @ trr angle: Float pi / 2;
		lineTo: (x + w) @ (y + h - brr);
		cwArcTo: (x + w - brr) @ (y + h) angle: Float pi / 2;
		lineTo: (x + blr) @ (y + h);
		cwArcTo: x @ ((y + h) - blr) angle: Float pi / 2;
		close