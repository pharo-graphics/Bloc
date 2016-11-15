tests - unit - fill
testArrayFillThreeElements
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 3 withAll: 0.
	
	grid fill: array from: 1 to: 4 with: 1.

	self assert: array equals: #(1 1 1)