testing
hasWidthLimit
	"Return true if the width of the paragraph is limited, false otherwise"
	<return: #Boolean>
	
	^ self maxWidth isInfinite not