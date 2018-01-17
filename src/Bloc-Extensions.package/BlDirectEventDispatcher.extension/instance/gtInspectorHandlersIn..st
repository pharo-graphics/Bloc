*Bloc-Extensions
gtInspectorHandlersIn: aComposite
	<gtInspectorPresentationOrder: 80>

	^ handlers ifNotNil: [
		(handlers gtInspectorHandlersIn: aComposite)
			title: 'Handlers' ]