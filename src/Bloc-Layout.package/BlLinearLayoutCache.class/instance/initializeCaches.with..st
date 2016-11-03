initialization
initializeCaches: anElement with: anExtentMeasurementSpec
	widthMeasureSpec := anExtentMeasurementSpec widthSpec.
	heightMeasureSpec := anExtentMeasurementSpec heightSpec.
	widthMode := widthMeasureSpec mode.
	heightMode := heightMeasureSpec mode.
	maxBreadth := 0.
	totalLength := 0.
	totalWeight := 0.
	matchingMaxBreadth := 0.
	alternativeMaxBreadth := 0.
	matchBreadth := false