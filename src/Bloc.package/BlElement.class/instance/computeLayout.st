layout utilities
computeLayout
	"Private! Never use me outside of #forceLayout"
	| relayoutCounter maxRelayoutCount |

	relayoutCounter := 0.
	maxRelayoutCount := 100.
	[ self isLayoutRequested
		and: [ relayoutCounter < maxRelayoutCount ] ]
		whileTrue: [
			| widthSpec heightSpec maxExtent |
			
			maxExtent := self isAttachedToSceneGraph
				ifTrue: [ self space extent ]
				ifFalse: [ 800 @ 600 ].
			
			widthSpec := BlMeasurementSpec new beAtMost: maxExtent x.
			heightSpec := BlMeasurementSpec new beAtMost: maxExtent y.

			self measure: (BlExtentMeasurementSpec new
				widthSpec: (self layout
					measurementSpecFor: widthSpec
					usedSize:  0
					resizer: self constraints horizontal resizer);
				heightSpec: (self layout
					measurementSpecFor: heightSpec
					usedSize:  0
					resizer: self constraints vertical resizer)).
			
			"...then we layout in measured on previous step bounds"
			self applyLayoutIn: self measuredBounds asRectangle.
			
			self commitChanges.
			
			relayoutCounter := relayoutCounter + 1 ]