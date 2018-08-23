testing
overlaps: aMonotoneTextSelection
	"Return true I overlap with a given monotone text selection, false otherwise.
	Intervals such as [6, 7] and [7, 9] are considered to be overllaping,
	while intervals [5, 6] and [7, 9] do *not* overlap"
	<return: #Boolean>

	^ (self rangeIncludes: aMonotoneTextSelection from)
		or: [ (self rangeIncludes: aMonotoneTextSelection to)
			or: [ (aMonotoneTextSelection rangeIncludes: self from)
				or: [ (aMonotoneTextSelection rangeIncludes: self to) ] ] ]