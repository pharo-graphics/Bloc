Extension { #name : #BlHandlerAnnouncerRegistry }

{ #category : #'*Bloc-Extensions' }
BlHandlerAnnouncerRegistry >> gtInspectorSubscriptionsIn: aComposite [
	<gtInspectorPresentationOrder: 2>

	^ aComposite list
		title: 'Subscriptions';
		display: [ self subscriptions ]
]
