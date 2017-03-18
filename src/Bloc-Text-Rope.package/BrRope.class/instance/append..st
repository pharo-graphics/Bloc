rope - accessing
append: aRope
	"Create and return a new rope by append a given rope to the of end of me"
	<return: #BrRope>

	^ self class concatenate: self and: aRope