Extension { #name : #BlTextAttributesStyler }

{ #category : #'*Bloc-Extensions' }
BlTextAttributesStyler >> gtInspectorTextAttributesIn: aComposite [
	<gtInspectorPresentationOrder: 0>

	^ aComposite fastList
		title: 'Text attributes' translated;
		display: [ self attributesBuilder attributes ];
		when: [ self respondsTo: #attributes ]
]
