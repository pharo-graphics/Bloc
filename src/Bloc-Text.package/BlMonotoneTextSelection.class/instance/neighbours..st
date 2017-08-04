testing
neighbours: aMonotoneTextSelection
	"Return true if I am a neighour of a given interval, false otherwise.
	Overlapping intervals are not considered as neighbours"
	<return: #Boolean>
	
	"I am to the left"
	^ ((self to + 1) = aMonotoneTextSelection from)
			"I am to the right"
			or: [ (self from - 1) = aMonotoneTextSelection to ]