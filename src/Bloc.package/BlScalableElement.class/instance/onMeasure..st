layout
onMeasure: anExtentMeasurementSpec
	| aScaleFactor aTransformedExtent |
	"First we perform a default measurement"
	super onMeasure: anExtentMeasurementSpec.
	
	self hasContentElement
		ifFalse: [ ^ self ].
	
	"and then we scale a content element according to scaling strategy"
	aScaleFactor := self scaleStrategy scale: self contentElement within: self.
	"we must not scale by zero! Otherwise matrix becomes singular"
	aScaleFactor isZero ifTrue: [ aScaleFactor := 1.0 ].
	
	self contentElement transform
		scaleBy: (aScaleFactor, aScaleFactor);
		apply.
		
	aTransformedExtent := self contentElement measuredBounds transformed extent.
	self measuredExtent: (anExtentMeasurementSpec sizeFor: aTransformedExtent)