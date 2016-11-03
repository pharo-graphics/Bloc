pulse
doLayout
| relayoutCounter maxRelayoutCount  |

	
	relayoutCounter := 0.
	maxRelayoutCount := 100.
	
	[ self root requestingLayout
		and: [ relayoutCounter < maxRelayoutCount ] ]
		whileTrue: [
			self doUpdateLayout.
			relayoutCounter := relayoutCounter + 1 ].
	
	