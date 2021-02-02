Extension { #name : #BlCompositionLeftoverStateLayer }

{ #category : #'*Bloc-Extensions' }
BlCompositionLeftoverStateLayer >> gtStateCommandsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'State commands';
		priority: 4;
		object: [ self state ];
		view: #gtCommandsFor:
]
