*Bloc-Sparta
asSpartaForm
	|canvas margin aBounds|
	margin := 0.

	aBounds := (self transform localBoundsToGlobal: self boundsInLocal).

	canvas := MozCanvas checker: (aBounds extent max: 1@1).

	canvas transform
		translateBy: aBounds origin negated + (margin / 2.0);
		apply.

	self fullDrawOnSpartaCanvas: canvas.

	^ canvas asForm