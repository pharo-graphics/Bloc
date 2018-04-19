*Bloc-Extensions
gtInspectorAnimationsIn: aComposite
	<gtInspectorPresentationOrder: 2>

	^ aComposite fastList
		title: 'Animations';
		display: [ self animations ]