updating
updateMetrics: anElement

	extentMetric text: (self extentTextFor: anElement extent).
	marginMetric insets: anElement margin.
	paddingMetric insets: anElement padding.