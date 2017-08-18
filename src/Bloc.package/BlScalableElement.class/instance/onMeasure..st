layout
onMeasure: anExtentMeasurementSpec
	| aTranslation oldExtent |
	super onMeasure: anExtentMeasurementSpec.
	
	self hasContentElement
		ifFalse: [ ^ self ].
	
	oldExtent := self contentElement measuredExtent.
	self contentElement scaleTo: (self measuredExtent / self contentElement measuredExtent) min asPoint.
	
	aTranslation := (self contentElement transform transformBounds: (self contentElement measuredBounds: BlBounds new)) extent - oldExtent.
	self contentElement translateTo: (aTranslation / 2.0) negated