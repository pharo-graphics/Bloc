Extension { #name : 'BlChildren' }

{ #category : '*Bloc-Extensions' }
BlChildren >> gtInspectorChildrenIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastList
		title: 'Children';
		display: [ self ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		icon: [:each | | morphForm |
			morphForm := each asSpartaForm.
			(morphForm extent x > 0 and: [ morphForm extent y > 0 ])
				ifTrue: [ (morphForm scaledToSize: 16@16) asMorph]
				ifFalse: [ Form extent: 16@16 ] ]
]
