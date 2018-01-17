*Bloc-Extensions
gtInspectorHandlersIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite list
		title: 'Handlers';
		display: [ self handlers ]