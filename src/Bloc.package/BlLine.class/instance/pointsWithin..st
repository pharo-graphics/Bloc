private
pointsWithin: aBounds
	| scaleFactor translation newFrom newTo |
	scaleFactor := aBounds extent / (self from max: self to).
	translation := aBounds origin - (self from min: self to).
	newFrom := (self from x * scaleFactor x) @ (self from y * scaleFactor y) + translation.
	newTo := (self to x * scaleFactor x) @ (self to y * scaleFactor y) + translation.
	^ newFrom corner: newTo