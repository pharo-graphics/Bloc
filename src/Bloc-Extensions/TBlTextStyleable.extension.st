Extension { #name : 'TBlTextStyleable' }

{ #category : '*Bloc-Extensions' }
TBlTextStyleable >> gtInspectorTextAttributesIn: aComposite [
	<gtInspectorPresentationOrder: 20>

	^ aComposite fastList
		title: 'Text attributes' translated;
		display: [ self attributesBuilder attributes ];
		when: [ self attributesBuilder respondsTo: #attributes ]
]
