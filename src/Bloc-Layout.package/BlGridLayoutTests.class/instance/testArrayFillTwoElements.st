tests - unit - fill
testArrayFillTwoElements
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 2 withAll: 0.
	
	grid fill: array from: 1 to: 3 with: 1.

	self assert: array equals: #(1 1)