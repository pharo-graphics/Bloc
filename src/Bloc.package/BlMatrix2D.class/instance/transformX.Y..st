matrix - transforming points
transformX: aX Y: aY
	| newX newY |
	
	newX := (aX * sx) + (aY * shx) + x.
	newY := (aX * shy) + (aY * sy) + y.

	^ newX @ newY