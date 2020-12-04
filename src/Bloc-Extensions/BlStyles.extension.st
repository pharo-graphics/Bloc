Extension { #name : #BlStyles }

{ #category : #'*Bloc-Extensions' }
BlStyles >> gtStylesFor: aView [
	<gtView>
	
	^ aView tree
		title: 'Styles';
		priority: 5;
		items: [ self styles ];
		children: [ :eachStyleOrProperty |
			(eachStyleOrProperty isKindOf: BlElementStyle)
				ifTrue: [ eachStyleOrProperty properties ]
				ifFalse: [ #() ] ];
		itemText: [ :eachStyleOrProperty |
			(eachStyleOrProperty isKindOf: BlElementStyle)
				ifTrue: [ eachStyleOrProperty state ]
				ifFalse: [ eachStyleOrProperty ] ];
		expandAll
]
