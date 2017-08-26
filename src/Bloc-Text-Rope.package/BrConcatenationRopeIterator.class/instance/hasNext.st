iterator - testing
hasNext
	"Return true if iterator is be able to return #next item in the rope, meaning that is
	didn't reached the end, false otherwise"
	<return: #Boolean>

	self assertInvariant.

	^ rope isNotEmpty
		and: [ (position <= rope size)
			and: [ position <= end
				and: [ position > 0 ] ] ]