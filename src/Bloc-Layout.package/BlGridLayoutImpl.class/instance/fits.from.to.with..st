private utilities
fits: anArray from: fromIndex to: toIndex with: value
	"Return true if value fits inside array within interval
	fromIndex to toIndex exclusive, false otherwise.
	Value 'fits' in array if it is less or equal to all elements
	in array within specified range.
	fromIndex must be greater than 0"
	<return: #Boolean>

	self
		assert: [ fromIndex > 0 ]
		description: [ 'From index must be greater than 0' ].

	((toIndex - 1) > anArray size)
		ifTrue: [ ^ false ].

	^ (fromIndex to: (toIndex - 1)) allSatisfy: [ :i | (anArray at: i) <= value ]