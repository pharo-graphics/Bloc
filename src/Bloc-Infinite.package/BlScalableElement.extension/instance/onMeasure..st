layout
onMeasure: anExtentMeasurementSpec
	| aTranslation oldExtent scaleFactor scaledBounds |
	super onMeasure: anExtentMeasurementSpec.
	
	self hasContentElement
		ifFalse: [ ^ self ].
	
	oldExtent := self contentElement measuredExtent.
	scaleFactor := ((self measuredExtent / self contentElement measuredExtent) min max: 0.01).

	self contentElement scaleTo: scaleFactor asPoint.
	
	scaledBounds := self contentElement transform transformBounds: (self contentElement measuredBounds: BlBounds new).

	aTranslation := scaledBounds extent - oldExtent.
	self contentElement translateTo: (aTranslation / 2.0) negated