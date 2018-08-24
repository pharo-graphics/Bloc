Extension { #name : #BlDirectEventDispatcher }

{ #category : #'*Bloc-Extensions' }
BlDirectEventDispatcher >> gtInspectorFiltersIn: aComposite [
	<gtInspectorPresentationOrder: 80>

	^ filters ifNotNil: [
		(filters gtInspectorHandlersIn: aComposite)
			title: 'Filters' ]
]

{ #category : #'*Bloc-Extensions' }
BlDirectEventDispatcher >> gtInspectorHandlersIn: aComposite [
	<gtInspectorPresentationOrder: 80>

	^ handlers ifNotNil: [
		(handlers gtInspectorHandlersIn: aComposite)
			title: 'Handlers' ]
]
