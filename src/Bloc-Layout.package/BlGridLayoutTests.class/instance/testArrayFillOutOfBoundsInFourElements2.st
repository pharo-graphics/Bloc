tests - unit - fill
testArrayFillOutOfBoundsInFourElements2
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid fill: array from: 1 to: 6 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 