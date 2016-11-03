*Bloc-Athens
loadAffineTransform: m
	| t |
	t := m asAthensAffineTransform.
	x := t x.
	y := t y.
	sx := t sx.
	sy := t sy.
	shx := t shx.
	shy := t shy.