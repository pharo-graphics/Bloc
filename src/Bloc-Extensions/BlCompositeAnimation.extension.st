Extension { #name : #BlCompositeAnimation }

{ #category : #'*Bloc-Extensions' }
BlCompositeAnimation >> gtInspectorAnimationsIn: aComposite [
	<gtInspectorPresentationOrder: 2>

	^ aComposite fastList
		title: 'Animations';
		display: [ self animations ]
]
