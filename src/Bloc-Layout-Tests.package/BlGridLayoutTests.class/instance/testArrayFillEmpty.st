tests - unit - fill
testArrayFillEmpty
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	grid fill: array from: 0 to: 1 with: 1.

	self assert: array equals: #()