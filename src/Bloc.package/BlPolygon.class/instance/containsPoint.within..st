geometry testing
containsPoint: aPoint within: aBounds
	| j x y flag scaleFactor translation |
	scaleFactor := aBounds extent / self extent.
	translation :=  aBounds origin - vertices min.
	flag := false.
	x := (aPoint x / scaleFactor x) - translation x.
	y := (aPoint y / scaleFactor y) - translation y.
	j := vertices size.
	vertices withIndexDo: [ :v :i |  | xi yi xj yj |
			xi := v x.
			yi := v y.
			xj := (vertices at: j) x.
			yj := (vertices at: j) y.
			((yi > y = (yj > y)) not and: [ x < ((xj - xi) * (y - yi) / (yj - yi) + xi) ]) ifTrue: [ flag := flag not ].
			j := i ].
	^ flag