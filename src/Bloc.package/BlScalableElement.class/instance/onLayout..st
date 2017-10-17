layout
onLayout: aBounds
	| aContentBounds |

	self hasContentElement
		ifFalse: [ ^ self ].

	aContentBounds := BlBounds origin: 0 @ 0 extent: self contentElement measuredExtent.
	aContentBounds translateBy: (self measuredExtent - aContentBounds extent) / 2.0.
	
	self contentElement applyLayoutIn: aContentBounds