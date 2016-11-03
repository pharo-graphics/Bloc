layout
forceLayout
	| relayoutCounter maxRelayoutCount|
	relayoutCounter := 0.
	maxRelayoutCount := 100.
	[ self layout requestingLayout
		and: [ relayoutCounter < maxRelayoutCount ] ]
		whileTrue: [
			self measure: (BlExtentMeasurementSpec new
				widthSpec: (self layout
					measurementSpecFor: (BlMeasurementSpec new beAtMost: Float infinity)
					usedSize:  0
					resizer: self constraints horizontal resizer);
				heightSpec: (self layout
					measurementSpecFor: (BlMeasurementSpec new beAtMost: Float infinity)
					usedSize:  0
					resizer: self constraints vertical resizer)).
			"...then we layout in measured on previous step bounds"
			self applyLayoutIn: self measuredBounds.
			relayoutCounter := relayoutCounter + 1 ]