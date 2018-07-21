*Bloc-Extensions
gtInspectorSelectionGraphIn: aComposite
	<gtInspectorPresentationOrder: 1> 
	
	^ aComposite blocMondrian
		title: 'Tree';
		painting: [ :mondrian :x :presentation | self paintTreeWith: mondrian ]