drag and drop
lift: aPoint in: anElement
	"Lift previews at a given point in space coordinates"

	anElement addChildren: (self items collect: [ :aDragItem |
		aDragItem previewElement relocate: aPoint
	])