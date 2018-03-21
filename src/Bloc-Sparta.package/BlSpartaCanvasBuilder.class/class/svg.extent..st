api - instance creation
svg: aFileName extent: aPoint
	"Create a canvas for svg output of a given size"
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility