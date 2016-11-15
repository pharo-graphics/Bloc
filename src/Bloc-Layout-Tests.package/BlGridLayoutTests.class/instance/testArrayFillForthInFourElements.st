tests - unit - fill
testArrayFillForthInFourElements
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 4 to: 5 with: 1.

	self assert: array equals: #(0 0 0 1)