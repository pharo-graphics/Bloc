Extension { #name : #BlTextAttributesBuilder }

{ #category : #'*Bloc-Extensions' }
BlTextAttributesBuilder >> gtInspectorPreviewIn: aComposite [
	<gtInspectorPresentationOrder: -10>

	^ aComposite blocText
		title: '_Preview';
		display: [ self applyOn: 'All their equipment and instruments are alive' asRopedText  ]
]
