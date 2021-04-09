Extension { #name : #BlEventDispatcherChain }

{ #category : #'*Bloc-Extensions' }
BlEventDispatcherChain >> gtInspectorDispatchersIn: aComposite [
	<gtInspectorPresentationOrder: 80>

	^ aComposite fastTable
		title: 'Dispatchers';
		display: [ self withAllPrevious reversed select: #hasDispatcher thenCollect: #dispatcher ];
		column: 'Dispatcher' evaluated: #yourself;
		column: 'Type' evaluated: #type
]
