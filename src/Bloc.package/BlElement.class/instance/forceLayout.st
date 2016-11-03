layout
forceLayout
	| relayoutCounter maxRelayoutCount|
	relayoutCounter := 0.
	maxRelayoutCount := 100.
	[ self layout requestingLayout
		and: [ relayoutCounter < maxRelayoutCount ] ]
		whileTrue: [
			self measure: (BlExtentMeasurementSpec exact: self extent).
			"...then we layout in measured on previous step bounds"
			self applyLayoutIn: self measuredBounds.
			relayoutCounter := relayoutCounter + 1 ]