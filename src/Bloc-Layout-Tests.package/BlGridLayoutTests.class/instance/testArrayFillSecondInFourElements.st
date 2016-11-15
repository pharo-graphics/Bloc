tests - unit - fill
testArrayFillSecondInFourElements
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 2 to: 3 with: 1.

	self assert: array equals: #(0 1 0 0)