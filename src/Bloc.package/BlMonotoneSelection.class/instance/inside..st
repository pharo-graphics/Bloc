testing
inside: aMonotoneTextSelection
	"Return true if I am fully inside a given selection, false otherwise"
	<return: #Boolean>
	
	^ self from > aMonotoneTextSelection from
		and: [ self to < aMonotoneTextSelection to ]