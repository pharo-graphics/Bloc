Extension { #name : #BlChildrenSubset }

{ #category : #'*Bloc-Extensions' }
BlChildrenSubset >> gtInspectorSetTreeIn: aComposite [
	<gtInspectorPresentationOrder: 3>
	
	^ aComposite tree 
		title: 'Tree' translated;
		allExpanded;
		display: [ { self } ];
		children: [ :each | each hasSuperset ifTrue: [ { each superset } ] ifFalse: [ #() ] ];
		when: [ self hasSuperset ]
]

{ #category : #'*Bloc-Extensions' }
BlChildrenSubset >> gtInspectorSupersetChildrenIn: aComposite [
	<gtInspectorPresentationOrder: 2>

	^ aComposite fastList
		title: 'Superset';
		display: [ self superset ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		icon: [:each | | morphForm |
			morphForm := each asSpartaForm.
			(morphForm extent x > 0 and: [ morphForm extent y > 0 ])
				ifTrue: [ (morphForm scaledToSize: 16@16) asMorph]
				ifFalse: [ Form extent: 16@16 ] ]
]
