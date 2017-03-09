layout
shouldMeasure: anExtentMeasurementSpec
	| aHeightSpec aWidthSpec isWidthValid isHeightValid |
		
	"If we don't have text layout we must re-measure"
	textLayout
		ifNil: [ ^ true ].

	self isLayoutRequested
		ifTrue: [ ^ true ].

	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.

	"If any spec is exact we must re-measure. Exact limit available height and width"
	(aWidthSpec isExact or: [ aHeightSpec isExact ])
		ifTrue: [ ^ true ].

	isWidthValid := aWidthSpec isUnspecified or: [ 
		"at most size"
		aWidthSpec size >= textLayout width ].
	
	isHeightValid := aHeightSpec isUnspecified or: [ 
		"at most size"
		aHeightSpec size >= textLayout height ].
	
	^ (isWidthValid and: [ isHeightValid ]) not