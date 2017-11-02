testing
closeTo: aBlBounds
	"Return true if I am close to the given bounds"
	<return: #Boolean>
	
	^ (self left closeTo: aBlBounds left)
		and: [ (self right closeTo: aBlBounds right)
			and: [ (self top closeTo: aBlBounds top)
				and: [ (self bottom closeTo: aBlBounds bottom) ] ] ]