*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas within: aBounds
	<return: #TSpartaPath>

	^ cornerRadii max isZero
		"Rectangle is polymorphic with SpartaPath"
		ifTrue: [ aBounds ]
		ifFalse: [ aCanvas shape roundedRectangle: aBounds radii: cornerRadii ]