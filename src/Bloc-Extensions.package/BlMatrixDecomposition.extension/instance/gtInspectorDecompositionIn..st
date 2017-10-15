*Bloc-Extensions
gtInspectorDecompositionIn: aComposite
	<gtInspectorPresentationOrder: 9>
	
	^ (self asDictionary gtInspectorItemsIn: aComposite)
		title: 'Decomposition'