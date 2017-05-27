updating
updateMetrics: anElement
	| geometryBounds visualBounds borderInsets |
	
	geometryBounds := anElement geometryBounds.
	visualBounds := anElement visualBounds.
	borderInsets := BlInsets
		top: (((geometryBounds top - visualBounds top) max: 0) round: 3)
		right: (((visualBounds right - geometryBounds right) max: 0) round: 3)
		bottom: (((visualBounds bottom - geometryBounds bottom) max: 0) round: 3)
		left: (((geometryBounds left - visualBounds left) max: 0) round: 3).
	
	extentMetric text: (self extentTextFor: geometryBounds extent).
	marginMetric insets: anElement margin.
	borderMetric insets: borderInsets.
	paddingMetric insets: anElement padding.