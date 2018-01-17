*Bloc-Extensions
gtInspectorSubscriptionsIn: aComposite
	<gtInspectorPresentationOrder: 2>

	^ aComposite list
		title: 'Subscriptions';
		display: [ self subscriptions ]