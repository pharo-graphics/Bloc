*Bloc-Extensions
gtInspectorFiltersIn: aComposite
	<gtInspectorPresentationOrder: 80>

	^ filters ifNotNil: [
		(filters gtInspectorHandlersIn: aComposite)
			title: 'Filters' ]