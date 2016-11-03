geometry testing
containsPoint: aPoint within: aBounds
	| w h x y center xRadius yRadius normalized|
	w := aBounds extent x.
	h := aBounds extent y.
	x := aBounds origin x.
	y := aBounds origin y.
	xRadius :=w / 2.0.
	yRadius :=h / 2.0.
	center := (x+xRadius)@(y+yRadius).
	(xRadius <= 0 or:[yRadius <= 0]) ifTrue:[^ false].
	normalized := (aPoint x - center x)@(aPoint y - center y).
	^ ((normalized x squared / xRadius squared) + (normalized y squared / yRadius squared)) <= 1