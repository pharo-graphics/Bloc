api - instance creation
pdf: aFileName extent: aPoint
	"Create a canvas for pdf output of a given size"
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility