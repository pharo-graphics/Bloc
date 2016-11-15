tests - unit - fill
testArrayFillTwoInFourElements2
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 2 to: 4 with: 1.

	self assert: array equals: #(0 1 1 0)