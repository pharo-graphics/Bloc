Extension { #name : #BlTextAttributesBuilder }

{ #category : #'*Bloc-Extensions' }
BlTextAttributesBuilder >> gtInspectorPreviewIn: aComposite [
	<gtInspectorPresentationOrder: -10>

	^ aComposite blocText
		title: '_Preview';
		display: [ self applyOn: 'All their equipment and instruments are alive' asRopedText  ]
]

{ #category : #'*Bloc-Extensions' }
BlTextAttributesBuilder >> gtInspectorTextAttributesIn: aComposite [
	<gtInspectorPresentationOrder: 0>

	^ aComposite fastList
		title: 'Text attributes' translated;
		display: [ self attributesBuilder attributes ];
		when: [ self respondsTo: #attributes ]
]
