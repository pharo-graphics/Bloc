*Bloc-Extensions
gtInspectorTraversedTargetsIn: aComposite
	<gtInspectorPresentationOrder: 10>

	^ aComposite table
		title: 'Traversed';
		display: [ self traversedTargets ];
		column: 'Target'
			evaluated: [ :each | each key ];
		column: 'Dispatcher'
			evaluated: [ :each | each value ];
		send: #key