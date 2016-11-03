*Bloc-Athens
buildAthensPathOn: aPathBuilder within: aBounds
	| w h x y halfWidth halfHeight |
	w := aBounds extent x.
	h := aBounds extent y.
	x := aBounds origin x.
	y := aBounds origin y.
	halfWidth := w / 2.0.
	halfHeight := h / 2.0.

	aPathBuilder
		relative;
		moveTo: halfWidth @ y;
		curveVia: (halfWidth * 0.55) @ y
			and: halfWidth @ (halfHeight * 0.45)
			to: halfWidth @ halfHeight;
		curveVia: x @ (halfHeight * 0.55)
			and: (halfWidth negated * 0.45) @ halfHeight
			to: halfWidth negated @ halfHeight;
		curveVia: (halfWidth negated * 0.55) @ y
			and: (halfWidth negated) @ (halfHeight negated * 0.45)
			to: halfWidth negated @ (halfHeight negated);
		curveVia: x @ (halfHeight negated * 0.55)
			and: (halfWidth * 0.45) @ (halfHeight negated)
			to: halfWidth @ (halfHeight negated)