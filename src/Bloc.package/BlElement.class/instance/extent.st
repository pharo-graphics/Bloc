api - bounds
extent
	"Return my extent as it was computed during previous layout pass.
	Extent is a point with `x` component representing my width
	and y component representing my height accordingly"
	<return: #Point>

	^ self bounds extent