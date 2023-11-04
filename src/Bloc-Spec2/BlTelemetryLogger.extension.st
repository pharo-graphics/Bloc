Extension { #name : 'BlTelemetryLogger' }

{ #category : '*Bloc-Spec2' }
BlTelemetryLogger >> inspectorTreeIn: aBuilder [
	<inspectorPresentationOrder: 3 title: 'Tasks Tree'>

	| refreshBlock tree |
	tree := aBuilder newTree
		display: [ :each | each asString ];
		children: [ :each | each tasks ];
		yourself.

	refreshBlock := [ tree items: (self recordings reverse collect: #task) ].
	refreshBlock value.
	self announcer weak when: Announcement do: refreshBlock.
	
	^ tree
]
