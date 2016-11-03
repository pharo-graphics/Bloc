tests - unit - fill
testArrayFillOutOfBoundsInFourElements1
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid fill: array from: 0 to: 3 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 