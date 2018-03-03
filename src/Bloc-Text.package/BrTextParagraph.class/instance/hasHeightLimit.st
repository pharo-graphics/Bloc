testing
hasHeightLimit
	"Return true if the height of the paragraph is limited, false otherwise"
	<return: #Boolean>
	
	^ self maxHeight isInfinite not