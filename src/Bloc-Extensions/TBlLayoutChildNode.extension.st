Extension { #name : 'TBlLayoutChildNode' }

{ #category : '*Bloc-Extensions' }
TBlLayoutChildNode >> gtMeasurementFor: aView [
	<gtView>
	
	^ ({
		#extent -> self extent.
		#position -> self position.
		#layoutBounds -> self layoutBounds.
	 } asOrderedDictionary gtItemsFor: aView)
			title: 'Metrics';
			priority: 2
]
