Extension { #name : #BlSpaceFrame }

{ #category : #'*Bloc-Extensions' }
BlSpaceFrame >> gtInspectorPhasesIn: aComposite [
	<gtInspectorPresentationOrder: 0>
	
	^ aComposite fastList
		title: 'Phases';
		display: [ self phases ];
		format: [ :each | each = self currentPhase
			ifTrue: [ each name asText allBold ]
			ifFalse: [ each name ] ]
]
