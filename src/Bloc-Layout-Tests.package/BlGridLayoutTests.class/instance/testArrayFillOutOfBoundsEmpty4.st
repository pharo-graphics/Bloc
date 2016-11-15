tests - unit - fill
testArrayFillOutOfBoundsEmpty4
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: 0 to: 2 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 