Extension { #name : #BlText }

{ #category : #'*Bloc-Extensions' }
BlText >> gtInspectorTextAttributesIn: aComposite [
	<gtInspectorPresentationOrder: 0>

	^ aComposite fastList
		title: 'Text attributes' translated;
		display: [ self attributesBuilder attributes ];
		when: [ self respondsTo: #attributes ]
]

{ #category : #'*Bloc-Extensions' }
BlText >> gtInspectorTextIn: composite [  
	<gtInspectorPresentationOrder: -10>
	
	composite blocText 
		title: '_Text';
		display: [ self ]
]
