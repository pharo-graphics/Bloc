layout
onMeasure: anExtentMeasurementSpec
	| myExtent |
	super onMeasure: anExtentMeasurementSpec.
	
	myExtent := contentElement measuredExtent.

	"include top label"
	myExtent := myExtent + (0@ topInsetElement measuredHeight).
	"include right label"
	myExtent := myExtent + (rightInsetElement measuredWidth @ 0).
	"include bottom label"
	myExtent := myExtent + (0@ bottomInsetElement measuredHeight).
	"include left label"
	myExtent := myExtent + (leftInsetElement measuredWidth @ 0).
	
	"include name label"
	myExtent := myExtent max: ((topInsetElement measuredWidth @ 0) + (labelElement measuredWidth * 2 @ 0)).

	self measuredExtent: myExtent.