*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas within: aBounds
	
	^ cornerRadii max isZero
		ifTrue: [ aBounds ]
		ifFalse: [ aCanvas shape roundedRectangle: aBounds radii: cornerRadii ]