tests - unit - fill
testArrayFillOneElement
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 1 withAll: 0.
	
	grid fill: array from: 1 to: 2 with: 1.

	self assert: array equals: #(1)