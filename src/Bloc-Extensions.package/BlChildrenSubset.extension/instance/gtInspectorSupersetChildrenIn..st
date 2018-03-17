*Bloc-Extensions
gtInspectorSupersetChildrenIn: aComposite
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