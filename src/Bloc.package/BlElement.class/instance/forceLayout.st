layout
forceLayout
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
			
			widthSpec := self constraints horizontal resizer isMatchParent
				ifTrue: [ BlMeasurementSpec new beAtMost: maxExtent x ]
				ifFalse: [ BlMeasurementSpec new beAtMost: Float infinity ].
				
			heightSpec := self constraints vertical resizer isMatchParent
				ifTrue: [ BlMeasurementSpec new beAtMost: maxExtent y ]
				ifFalse: [ BlMeasurementSpec new beAtMost: Float infinity ].
			
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
			
			self notifyChanges.
			
			relayoutCounter := relayoutCounter + 1 ]