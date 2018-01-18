*Bloc-Extensions
gtInspectorTraversedTargetsIn: aComposite
	<gtInspectorPresentationOrder: 10>

	^ aComposite table
		title: 'Traversed';
		display: [ self traversedTargets ];
		icon: [ :each | each target asSpartaForm scaledToSize: 16@16 ];
		column: 'Phase'
			evaluated: [ :each | each type ]
			width: 100;
		column: 'Target'
			evaluated: [ :each | each target ];
		column: 'Dispatcher'
			evaluated: [ :each | each dispatcher ]