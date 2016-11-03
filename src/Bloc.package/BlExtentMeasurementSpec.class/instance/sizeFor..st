geometry
sizeFor: anExtent
	|width height|
	width := self widthSpec sizeFor: anExtent x.
	height := self heightSpec sizeFor: anExtent y.
	^ width@height