testing
overlaps: anInterval
	"Return true I overlap with a given interval, false otherwise"
	<return: #Boolean>
	
	^ (self rangeIncludes: anInterval first)
		or: [ (self rangeIncludes: anInterval last)
			or: [ (anInterval rangeIncludes: self from)
				or: [ (anInterval rangeIncludes: self to) ] ] ]