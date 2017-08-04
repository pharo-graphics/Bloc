testing
includes: aMonotoneTextSelection
	"Return true if I include a given selection, false otherwise"
	<return: #Boolean>
	
	^ aMonotoneTextSelection from >= self from
		and: [ aMonotoneTextSelection to <= self to ]