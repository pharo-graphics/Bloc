Extension { #name : 'BlLayoutChildNodeWithEdges' }

{ #category : '*Bloc-Extensions' }
BlLayoutChildNodeWithEdges >> gtConnectedEdgesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Connected edges';
		priority: 5;
		items: [ self connectedEdges ]
]

{ #category : '*Bloc-Extensions' }
BlLayoutChildNodeWithEdges >> gtIncomingEdgesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Incoming edges';
		priority: 6;
		object: [ self incomingEdges ];
		view: #gtItemsFor:
]

{ #category : '*Bloc-Extensions' }
BlLayoutChildNodeWithEdges >> gtOutgoingEdgesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Outgoing edges';
		priority: 7;
		object: [ self outgoingEdges ];
		view: #gtItemsFor:
]
