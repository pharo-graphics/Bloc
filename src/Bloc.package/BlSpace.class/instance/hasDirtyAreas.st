testing
hasDirtyAreas
	"Return true if space has dirty areas and therefore needs to be rendered,
	false otherwise"
	<return: #Boolean>
	
	^ self dirtyAreas isNotEmpty