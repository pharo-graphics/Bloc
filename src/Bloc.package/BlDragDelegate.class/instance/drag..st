drag and drop
drag: aPoint
	"Drag all previews to a given point in parent coordinates of previews"
	
	self items do: [ :aDragItem | aDragItem previewElement relocate: aPoint ]