Extension { #name : #BlTelemetryLogger }

{ #category : #'*Bloc-Spec2' }
BlTelemetryLogger >> inspectorTreeIn: aBuilder [
	<inspectorPresentationOrder: 3 title: 'Tasks Tree'>

	^ aBuilder newTree
		display: [ :each | each asString ];
		children: [ :each | each tasks ];
		items: (self recordings reverse collect: #task);
		yourself
]
