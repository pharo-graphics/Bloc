tests - unit - fill
testArrayFillOutOfBoundsEmpty1
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: -1 to: 0 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 