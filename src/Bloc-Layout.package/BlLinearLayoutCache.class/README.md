I represent a linear layout cache.

I store values used by LinearLayout during measurement and layout passes.

I am used by LinearLayout.

Public API and Key Messages

	Setters and getters for different temporary variables used during measurement and layout passes.

 
Internal Representation and Key Implementation Points.

    Instance Variables
	alternativeMaxBreadth:		<Number>
	heightMeasureSpec:		<BlMeasurementSpec>
	heightMode:		<BlMeasurementMode>
	length:		<Number>
	matchBreadth:		<Boolean>
	matchingMaxBreadth:		<Number>
	maxBreadth:		<Number>
	totalLength:		<Number>
	totalWeight:		<Number>
	widthMeasureSpec:		<BlMeasurementSpec>
	widthMode:		<BlMeasurementMode>