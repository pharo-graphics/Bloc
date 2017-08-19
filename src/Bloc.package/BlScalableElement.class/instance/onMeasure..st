layout
onMeasure: anExtentMeasurementSpec
	| aTranslation oldExtent scaleFactor scaledBounds aMeasuredWidth aMeasuredHeight  |
	super onMeasure: anExtentMeasurementSpec.
	
	self hasContentElement
		ifFalse: [ ^ self ].
	
	oldExtent := self contentElement measuredExtent.
	scaleFactor := ((self measuredExtent / self contentElement measuredExtent) min max: 0.01).

	self contentElement scaleTo: scaleFactor asPoint.
	
	scaledBounds := self contentElement transform transformBounds: (self contentElement measuredBounds: BlBounds new).

	aTranslation := scaledBounds extent - oldExtent.
	self contentElement translateTo: (aTranslation / 2.0) negated.

	"we should take scaled bounds of content element into account"
	aMeasuredWidth := anExtentMeasurementSpec widthSpec sizeFor: scaledBounds width.
	aMeasuredHeight := anExtentMeasurementSpec heightSpec sizeFor: scaledBounds height.
		
	self measuredExtent: aMeasuredWidth @ aMeasuredHeight