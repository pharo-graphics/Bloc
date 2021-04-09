Extension { #name : #BlHandlerRegistry }

{ #category : #'*Bloc-Extensions' }
BlHandlerRegistry >> gtInspectorHandlersIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite list
		title: 'Handlers';
		display: [ self handlers ]
]
