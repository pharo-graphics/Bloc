testing
overlaps: aMonotoneTextSelection
	"Return true I overlap with a given monotone text selection, false otherwise"
	<return: #Boolean>
	
	^ (self rangeIncludes: aMonotoneTextSelection from)
		or: [ (self rangeIncludes: aMonotoneTextSelection to)
			or: [ (aMonotoneTextSelection rangeIncludes: self from)
				or: [ (aMonotoneTextSelection rangeIncludes: self to) ] ] ]