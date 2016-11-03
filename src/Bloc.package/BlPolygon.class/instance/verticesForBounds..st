private
verticesForBounds: aBounds
	| scaleFactor translation|
	scaleFactor := aBounds extent / self extent.
	translation :=  aBounds origin - vertices min.
	^ vertices collect: [ :p | (((p x * scaleFactor x) @ (p y * scaleFactor y)) + translation) asFloatPoint]