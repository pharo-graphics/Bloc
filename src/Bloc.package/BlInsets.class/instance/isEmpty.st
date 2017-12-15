testing
isEmpty
	"Return true if insets is empty and does not influence bounds, false otherwise.
	Note: comparing the sum of width and height may lead to unexpected results when insets are negative"
	<return: #Boolean>

	^ self top isZero
		and: [ self right isZero
			and: [ self bottom isZero
				and: [ self left isZero ] ] ]