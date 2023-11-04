Extension { #name : 'BlElementStates' }

{ #category : '*Bloc-Spec2' }
BlElementStates >> inspectionItems: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Items'>

	| itemsToShow |
	itemsToShow := Array streamContents: [ :stream |
		localStates do: [ :each | each -> #local ].
		inheritedStates do: [ :each | each -> #inherited ] ].

	^ aBuilder newTable
		items: itemsToShow;
		addColumn: (SpStringTableColumn 
			title: 'State'
			evaluated: [ :assoc | assoc key ]);
		addColumn: (SpStringTableColumn 
			title: 'Type'
			evaluated: [ :assoc | assoc value ]);
"		updateWhen: #statesChanged in: self announcer;"
		yourself

]
