*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas
	<return: #TSpartaPath>

	^ cornerRadii max isZero
		"Rectangle is polymorphic with SpartaPath"
		ifTrue: [ self geometryBounds ]
		ifFalse: [ aCanvas shape roundedRectangle: self geometryBounds radii: cornerRadii ]