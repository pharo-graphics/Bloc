instance creation
createCanvas: anExtent
	"Create a suitable canvas of a given size used for the export"
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility