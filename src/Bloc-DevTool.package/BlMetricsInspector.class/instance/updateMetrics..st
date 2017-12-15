updating
updateMetrics: anElement
	| geometryBounds |
	
	geometryBounds := anElement geometryBounds.	
	marginMetric insets: anElement margin.
	paddingMetric insets: anElement padding.